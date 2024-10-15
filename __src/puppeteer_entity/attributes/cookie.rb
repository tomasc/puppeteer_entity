# frozen_string_literal: true

module Modulor
  class PuppeteerEntity
    module Attributes
      class Cookie < Dry::Struct
        transform_keys(&:to_sym)
        attribute :name, Types::Coercible::String
        attribute :value, Types::Coercible::String
        # The request-URI to associate with the setting of the cookie. This value can affect the default domain, path, source port, and source scheme values of the created cookie.
        attribute? :url, Types::URL.optional
        attribute? :domain, Types::Coercible::String.optional
        attribute? :path, Types::Coercible::String.optional
        attribute? :secure, Types::Bool.optional
        attribute? :http_only, Types::Bool.optional
        attribute? :same_site, Types::Coercible::String.enum("Lax", "None", "Strict").optional
        attribute? :expires, Types::Coercible::Integer.optional
        attribute? :priority, Types::Coercible::String.enum("High", "Low", "Medium").optional
        attribute? :same_party, Types::Bool.optional
        attribute? :source_scheme, Types::Coercible::String.enum("NonSecure", "Secure", "Unset").optional
        # Cookie source port. Valid values are {-1, [1, 65535]}, -1 indicates an unspecified port. An unspecified port value allows protocol clients to emulate legacy cookie scope for the port. This is a temporary ability and it will be removed in the future.
        attribute? :source_port, Types::Coercible::Integer.optional
        # Cookie partition key. The site of the top-level URL the browser was visiting at the start of the request to the endpoint that set the cookie. If not set, the cookie will be set as not partitioned.
        attribute? :partition_key, Types::Coercible::String.optional
      end
    end
  end
end
