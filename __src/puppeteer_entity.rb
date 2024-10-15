# frozen_string_literal: true

require "active_support/gzip"
require "dry/initializer"
require "dry/transformer"
require "http"
require "universalid"
require "modulor/update_path"

module Modulor
  class PuppeteerEntity < Dry::Struct
    class RequestError < StandardError; end
    class IdLengthError < StandardError; end

    attr_writer :file_data

    attribute? :filename, Types::Coercible::String.optional

    attribute? :browserless_url, Types::URL.default { ENV["BROWSERLESS_URL"] }
    attribute? :cache_key, Types::Coercible::String.optional
    attribute? :retry_limit, Types::Integer.default { 3 } # number of retries for taking a screenshot

    attributes_from Attributes::Query

    def response
      url = browserless_uri.tap do |uri|
        uri.query = URI.encode_www_form(as_query_params)
      end.to_s

      retries = 0
      begin
        HTTP.headers(content_type: "application/json")
            .post(url, json: as_body_json)
            .tap do |res|
          raise RequestError.new(res.body.to_s) unless res.status.success?
        end
      rescue RequestError => e
        retries = retries + 1
        retries > retry_limit ? raise(e) : retry
      end
    end

    private
      def browserless_uri
        raise NotImplementedError
      end

      def as_query_params
        to_h
          .slice(*Attributes::Query.attribute_names)
          .reject { |_, v| v.blank? }
          .deep_stringify_keys
          .deep_transform_keys { |k| k.camelcase(:lower) }
      end

      def as_body_json
        raise NotImplementedError
      end
  end
end
