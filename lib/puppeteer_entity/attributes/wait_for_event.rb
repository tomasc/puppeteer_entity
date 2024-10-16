# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class WaitForEvent < Dry::Struct
      transform_keys(&:to_sym)

      attribute :event, Types::Coercible::String
      attribute? :timeout, Types::Coercible::Integer
    end
  end
end
