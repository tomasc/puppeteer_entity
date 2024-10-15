# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class WaitForSelector < Dry::Struct
        transform_keys(&:to_sym)

        attribute :selector, Types::Coercible::String
        attribute? :hidden, Types::Bool.optional
        attribute? :timeout, Types::Coercible::Integer.optional
        attribute? :visible, Types::Bool.optional
      end
    end
  end
end
