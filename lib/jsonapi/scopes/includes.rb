# frozen_string_literal: true

module Jsonapi
  module Include
    extend ActiveSupport::Concern

    module ClassMethods
      def apply_include(params)
        records = all
        fields = params.dig(:include).to_s.split(',').map(&:squish)
        allowed_fields = reflections.keys

        fields.each do |field|
          raise InvalidAttributeError, "#{field} is not valid as include attribute." unless allowed_fields.include?(field)
        end

        records.includes(*fields) if fields.present?

        records
      end
    end
  end
end
