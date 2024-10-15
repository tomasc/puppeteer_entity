# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class WaitForFunction < Dry::Struct
        transform_keys(&:to_sym)

        # The function, or statement, to be evaluated in browser context
        attribute :fn, Types::Coercible::String
        # An interval at which the pageFunction is executed, defaults to raf. If polling is a number, then it is treated as an interval in milliseconds at which the function would be executed. If polling is a string, then it can be one of the following values: "raf" or "mutation"
        attribute? :polling, Types::Coercible::String.optional
        # Maximum time to wait for in milliseconds. Defaults to 30000 (30 seconds). Pass 0 to disable timeout.
        attribute? :timeout, Types::Coercible::Integer.optional
      end
    end
  end
end
