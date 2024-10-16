# frozen_string_literal: true

module PuppeteerEntity
  class Screenshot < Base
    attributes_from Attributes::Screenshot

    transform_keys(&:to_sym)

    private

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
