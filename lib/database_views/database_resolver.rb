module DatabaseViews
  class DatabaseResolver < ActionView::Resolver
    include Singleton

    def find_templates(name, prefix, partial, details)
      @@model.find_templates(build_path(name, prefix), partial, details).map do |record|
        initialize_template(record)
      end
    end

    def self.using(model)
      @@model = model
      self.instance
    end

    private
    def initialize_template(record)
      source = record.source
      identifier = "#{record.class} - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.registered_template_handler(record.handlers)

      details = {
        format: Mime[record.formats],
        updated_at: record.updated_at,
        virtual_path: virtual_path(record.path, record.partial)
      }

      ActionView::Template.new(source, identifier, handler, details)
    end

    def build_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end

    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end
    end
  end
end