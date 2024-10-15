# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class GotoOptions < Dry::Struct
        transform_keys(&:to_sym)

        # If provided, it will take preference over the referer header value set by {@link Page.setExtraHTTPHeaderspage.setExtraHTTPHeaders()}.
        attribute? :referer, Types::Coercible::String.optional
        # If provided, it will take preference over the referer-policy header value set by {@link Page.setExtraHTTPHeaderspage.setExtraHTTPHeaders()}.
        attribute? :referrer_policy, Types::Coercible::String.optional
        # Maximum wait time in milliseconds. Pass 0 to disable the timeout.
        # The default value can be changed by using the {@link Page.setDefaultTimeout} or {@link Page.setDefaultNavigationTimeout} methods.
        attribute? :timeout, Types::Coercible::Integer.optional
        # When to consider waiting succeeds. Given an array of event strings, waiting is considered to be successful after all events have been fired.
        attribute? :wait_until, Types::Array.of(Types::Coercible::String.enum("domcontentloaded", "load", "networkidle0", "networkidle2")).optional
      end
    end
  end
end
