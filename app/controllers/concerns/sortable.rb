module Sortable
  extend ActiveSupport::Concern

  class_methods do
    attr_reader :sortable_fields

    def sortable_by(*fields)
      @sortable_fields = fields
    end
  end

  included do
    protected

    def sort(scope)
      sort_key = params[:sort_key]
      if sort_key.present?
        unless sortable_fields.include?(sort_key)
          raise ActionController::BadRequest, "sort_key must be one of [#{sortable_fields.join(", ")}]"
        end

        directions = ["asc", "desc"]
        sort_direction = (params[:sort_direction] || directions.first).downcase
        unless directions.include?(sort_direction)
          raise ActionController::BadRequest, "sort_direction must be one of [#{directions.join(", ")}]"
        end

        scope = scope.reorder("#{sort_key} #{sort_direction}")
        scope
      else
        scope
      end
    end

    private

    def sortable_fields
      self.class.sortable_fields || []
    end
  end
end
