# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class Pdf < Dry::Struct
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

      attribute? :block_modals, Types::Bool.optional

      attribute? :cookies, Types::Array do
        attributes_from Attributes::Cookie
      end

      attribute? :emulate_media_type, Types::Coercible::String.optional

      attribute? :goto_options do
        attributes_from Attributes::GotoOptions
      end

      attribute? :html, Types::Coercible::String.optional

      attribute? :options do
        attribute? :scale, Types::Float.optional.constrained(included_in: 0.1..2.0)
        attribute? :display_header_footer, Types::Bool.optional
        # HTML template for the print header. Should be valid HTML with the following classes used to inject values into them:
        # * "date" formatted print date
        # * "title" document title
        # * "url" document location
        # * "pageNumber" current page number
        # * "totalPages" total pages in the document
        attribute? :header_template, Types::Coercible::String.optional
        # HTML template for the print footer. Has the same constraints and support for special classes as {@link PDFOptionsPDFOptions.headerTemplate}.
        attribute? :footer_template, Types::Coercible::String.optional
        # Print background graphics.
        attribute? :print_background, Types::Bool.optional
        attribute? :landscape, Types::Bool.optional
        # Paper ranges to print, e.g. 1-5, 8, 11-13.
        attribute? :page_ranges, Types::Coercible::String.optional
        attribute? :format, Types::Coercible::String.enum("A0", "A1", "A2", "A3", "A4", "A5", "A6", "LEDGER", "LEGAL", "LETTER", "Ledger", "Legal", "Letter", "TABLOID", "Tabloid", "a0", "a1", "a2", "a3", "a4", "a5", "a6", "ledger", "legal", "letter", "tabloid").optional
        # Sets the width of paper. You can pass in a number or a string with a unit.
        attribute? :width, Types::Coercible::String.optional
        # Sets the height of paper. You can pass in a number or a string with a unit.
        attribute? :height, Types::Coercible::String.optional
        # Give any CSS @page size declared in the page priority over what is declared in the width or height or format option.
        attribute? :prefer_css_page_size, Types::Bool.optional
        attribute? :margin do
          attribute? :top, Types::Coercible::String.optional
          attribute? :bottom, Types::Coercible::String.optional
          attribute? :left, Types::Coercible::String.optional
          attribute? :right, Types::Coercible::String.optional
        end
        # The path to save the file to.
        attribute? :path, Types::String.optional
        # Hides default white background and allows generating pdfs with transparency.
        attribute? :omit_background, Types::Bool.optional
        # Generate tagged (accessible) PDF.
        attribute? :tagged, Types::Bool.optional
        # Timeout in milliseconds. Pass 0 to disable timeout.
        attribute? :timeout, Types::Coercible::Integer.optional
      end

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
