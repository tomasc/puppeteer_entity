# frozen_string_literal: true

module PuppeteerEntity
  class Pdf < Base
    attributes_from Attributes::Pdf

    transform_keys(&:to_sym)

    private

    def as_body_json
      to_h
        .slice(*Attributes::Pdf.attribute_names)
        .reject { |_, v| v.blank? }
        .deep_stringify_keys
        .deep_transform_keys do |k|
          case k
          when "set_extra_http_headers" then "setExtraHTTPHeaders"
          when "prefer_css_page_size" then "preferCSSPageSize"
          else k.camelcase(:lower)
          end
        end
    end

    def browserless_uri
      URI.parse(browserless_url).tap do |uri|
        uri.path = "/pdf"
      end
    end
  end
end
