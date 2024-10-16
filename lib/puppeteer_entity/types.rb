# frozen_string_literal: true

require "dry/types"

module PuppeteerEntity
  module Types
    include Dry.Types

    URL = Strict::String.constrained(format: URI::DEFAULT_PARSER.make_regexp)
  end
end
