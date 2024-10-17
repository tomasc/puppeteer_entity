# frozen_string_literal: true

module PuppeteerEntity
  class Screenshot < Base
    attributes_from Attributes::Screenshot

    MIME_TYPES = {
      "png" => "image/png",
      "jpeg" => "image/jpeg",
      "webp" => "image/webp"
    }.freeze

    transform_keys(&:to_sym)

    private

    def response_headers
      type = to_h.dig(:options, :type) || "png"
      super.merge(
        accept: MIME_TYPES[type.downcase]
      )
    end

    def as_body_json
      to_h
        .slice(*Attributes::Screenshot.attribute_names)
        .reject { |_, v| v.blank? }
        .deep_stringify_keys
        .deep_transform_keys do |k|
          case k
          when "set_extra_http_headers" then "setExtraHTTPHeaders"
          else k.camelcase(:lower)
          end
        end
    end

    def browserless_uri
      URI.parse(browserless_url).tap do |uri|
        uri.path = "/screenshot"
      end
    end
  end
end
