module Searchable
  extend ActiveSupport::Concern

  included do
    protected

    def search(scope)
      search = params[:search]
      if search.present?
        scope.search(params[:search].gsub(/-/, '\-'))
      else
        scope
      end
    end
  end
end
