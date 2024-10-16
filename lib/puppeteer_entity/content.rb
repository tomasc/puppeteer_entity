# frozen_string_literal: true

module PuppeteerEntity
  class Content < Base
    attributes_from Attributes::Content

    transform_keys(&:to_sym)

    private

    def as_body_json
      to_h
        .slice(*Attributes::Content.attribute_names)
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
        uri.path = "/content"
      end
    end
  end
end
