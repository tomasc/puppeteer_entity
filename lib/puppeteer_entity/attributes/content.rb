# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class Content < Dry::Struct
      transform_keys(&:to_sym)

      attribute? :add_script_tag, Types::Array do
        attributes_from Attributes::ScriptTag
      end

      attribute? :add_style_tag, Types::Array do
        attributes_from Attributes::StyleTag
      end

      attribute? :authenticate do
        attributes_from Attributes::Authenticate
      end

      # When bestAttempt is set to true, browserless attempt to proceed when "awaited" events fail or timeout. This includes things like goto, waitForSelector, and more.
      attribute? :best_attempt, Types::Bool.optional

      attribute? :cookies, Types::Array do
        attributes_from Attributes::Cookie
      end

      attribute? :emulate_media_type, Types::Coercible::String.optional

      attribute? :goto_options do
        attributes_from Attributes::GotoOptions
      end

      attribute? :html, Types::Coercible::String.optional

      attribute? :reject_request_pattern, Types::Array.of(Types::String).optional
      attribute? :reject_resource_types, Types::Array.of(Types::Coercible::String.enum("cspviolationreport", "document", "eventsource", "fetch", "font", "image", "manifest", "media", "other", "ping", "prefetch", "preflight", "script", "signedexchange", "stylesheet", "texttrack", "websocket", "xhr")).optional
      attribute? :request_interceptors, Types::Array.optional

      attribute? :set_extra_http_headers, Types::Array.optional
      attribute? :set_java_script_enabled, Types::Bool.optional

      attribute? :url, Types::URL.optional
      attribute? :user_agent, Types::Coercible::String.optional

      attribute? :viewport do
        attributes_from Attributes::Viewport
      end

      attribute? :wait_for_event do
        attributes_from Attributes::WaitForEvent
      end

      attribute? :wait_for_function do
        attributes_from Attributes::WaitForFunction
      end

      attribute? :wait_for_selector do
        attributes_from Attributes::WaitForSelector
      end

      attribute? :wait_for_timeout, Types::Coercible::Integer.optional
    end
  end
end
