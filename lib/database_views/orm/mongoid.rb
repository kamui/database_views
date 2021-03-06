module DatabaseViews
  module Orm
    module Mongoid
      extend ActiveSupport::Concern

      included do
        field :path
        field :contents
        field :formats, default: :html
        field :locale, default: :en
        field :handlers, default: :erb

        validates :formats,  inclusion: Mime::SET.symbols.map(&:to_s)
        validates :locale,  inclusion: I18n.available_locales.map(&:to_s)
        validates :handlers, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)
        validates :path, uniqueness: true, presence: true
        validates :contents, presence: true

        after_save do
         DatabaseViews::DatabaseResolver.instance.clear_cache
        end
      end

      module ClassMethods
        def find_templates(path, details)
          where(path: path).any_in(details)
        end

        def resolver
          DatabaseViews::DatabaseResolver.using self
        end
      end
    end
  end
end