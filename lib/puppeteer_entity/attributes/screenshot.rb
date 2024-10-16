# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class Screenshot < Dry::Struct
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

      attribute? :options do
        attribute? :optimize_for_speed, Types::Bool.optional
        attribute :type, Types::Coercible::String.default("png").enum("jpeg", "png", "webp")
        # Quality of the image, between 0-100. Not applicable to png images.
        attribute? :quality, Types::Integer.optional.constrained(included_in: 0..100)
        # Capture the screenshot from the surface, rather than the view.
        attribute? :from_surface, Types::Bool.optional
        # When true, takes a screenshot of the full page.
        attribute? :full_page, Types::Bool.optional
        # Hides default white background and allows capturing screenshots with transparency.
        attribute? :omit_background, Types::Bool.optional
        # The file path to save the image to. The screenshot type will be inferred from file extension. If path is a relative path, then it is resolved relative to current working directory. If no path is provided, the image won't be saved to the disk.
        attribute? :path, Types::String.optional
        attribute? :clip do
          attribute? :scale, Types::Float.optional
          # the width of the element in pixels.
          attribute :width, Types::Integer
          # the height of the element in pixels.
          attribute :height, Types::Integer
          attribute :x, Types::Integer
          attribute :y, Types::Integer
        end
        # Encoding of the image.
        attribute? :encoding, Types::Coercible::String.optional.enum("base64", "binary")
        # Capture the screenshot beyond the viewport.
        attribute? :capture_beyond_viewport, Types::Bool.optional
      end

      attribute? :reject_request_pattern, Types::Array.of(Types::String).optional
      attribute? :reject_resource_types, Types::Array.of(Types::Coercible::String.enum("cspviolationreport", "document", "eventsource", "fetch", "font", "image", "manifest", "media", "other", "ping", "prefetch", "preflight", "script", "signedexchange", "stylesheet", "texttrack", "websocket", "xhr")).optional
      attribute? :request_interceptors, Types::Array.optional

      attribute? :scroll_page, Types::Bool.optional
      attribute? :selector, Types::Coercible::String.optional

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
