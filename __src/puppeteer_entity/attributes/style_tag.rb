# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class StyleTag < Dry::Struct
        transform_keys(&:to_sym)

        # the URL of the CSS file to be added.
        attribute? :url, Types::URL.optional
        # The path to a CSS file to be injected into the frame.
        attribute? :path, Types::String.optional
        # Raw CSS content to be injected into the frame.
        attribute? :content, Types::String.optional
      end
    end
  end
end
