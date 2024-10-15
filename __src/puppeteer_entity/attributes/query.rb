# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class Query < Dry::Struct
        transform_keys(&:to_sym)

        # Whether or nor to load ad-blocking extensions for the session. This currently uses uBlock Origin and may cause certain sites to not load properly.
        attribute? :block_ads, Types::Bool.optional
        # Launch options, which can be either an object of puppeteer.launch options or playwright.launchServer options, depending on the API.
        attribute? :launch do
          attribute? :args, Types::Array.of(Types::String).optional
          attribute? :default_viewport do
            attributes_from Attributes::Viewport
          end
        end
        # Whether or nor to record the session. The browser will run in "head-full" mode, and recording is started and closed via the embedded browserless API. Please refer to the "Recording" section in the live documentation site for more details.
        attribute? :record, Types::Bool.optional
        # Override the system-level timeout for this request. Accepts a value in milliseconds.
        attribute? :timeout, Types::Integer.optional
        # The authorization token
        attribute? :token, Types::String.optional
      end
    end
  end
end
