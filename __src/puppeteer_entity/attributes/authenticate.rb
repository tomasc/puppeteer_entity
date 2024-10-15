# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class Authenticate < Dry::Struct
        transform_keys(&:to_sym)

        attribute :username, Types::Coercible::String
        attribute :password, Types::Coercible::String
      end
    end
  end
end
