# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class ScriptTag < Dry::Struct
      transform_keys(&:to_sym)

      # URL of the script to be added.
      attribute? :url, Types::URL.optional
      # Path to a JavaScript file to be injected into the frame.
      attribute? :path, Types::String.optional
      # JavaScript to be injected into the frame.
      attribute? :content, Types::String.optional
      # Sets the type of the script. Use module in order to load an ES2015 module.
      attribute? :type, Types::Coercible::String.optional
      # Sets the id of the script.
      attribute? :id, Types::Coercible::String.optional
    end
  end
end
