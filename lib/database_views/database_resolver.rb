module DatabaseViews
  class DatabaseResolver < ActionView::PathResolver
    include Singleton

    def self.using(model)
      @@model = model
      self.instance
    end

    private
    def query(path, details, formats)
      templates = []
      @@model.find_templates(path, details).map do |t|
        identifier = "#{t.class} - #{t.id} - #{t.path.inspect}"
        handler = ActionView::Template.registered_template_handler(t.handlers)
        templates << ActionView::Template.new(t.contents, identifier, handler, virtual_path: path.virtual, format: t.formats, updated_at: t.updated_at)
      end
      templates
    end
  end
end