# frozen_string_literal: true

module PuppeteerEntity
  module Attributes
    class Viewport < Dry::Struct
      transform_keys(&:to_sym)

      # The page width in CSS pixels.
      attribute :width, Types::Coercible::Integer
      # The page height in CSS pixels.
      attribute :height, Types::Coercible::Integer
      # Specify device scale factor. See {@link https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio devicePixelRatio} for more info.
      attribute? :device_scale_factor, Types::Coercible::Float.optional
      # Whether the meta viewport tag is taken into account.
      attribute? :is_mobile, Types::Bool.optional
      # Specifies if the viewport is in landscape mode.
      attribute? :is_landscape, Types::Bool.optional
      # Specify if the viewport supports touch events.
      attribute? :has_touch, Types::Bool.optional
    end
  end
end
