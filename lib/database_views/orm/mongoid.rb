module DatabaseViews
  module Orm
    module Mongoid
      extend ActiveSupport::Concern

      included do
        field :path
        field :source
        field :partial, type: Boolean, default: false
        field :formats, default: :html
        field :locale, default: :en
        field :handlers, default: :haml

        validates :formats,  inclusion: Mime::SET.symbols.map(&:to_s)
        validates :locale,  inclusion: I18n.available_locales.map(&:to_s)
        validates :handlers, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)
        validates :path, uniqueness: true, presence: true
        validates :source, presence: true

        after_save do
         DatabaseViews::DatabaseResolver.instance.clear_cache
        end
      end

      module ClassMethods
        def find_templates(path, partial = false, details)
          where(path: path, partial: partial).any_in(details)
        end

        def resolver
          DatabaseViews::DatabaseResolver.using self
        end
      end
    end
  end
end