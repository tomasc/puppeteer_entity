# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module PuppeteerEntity
  class Error < StandardError; end

  class RequestError < Error; end

  class IdLengthError < Error; end
end

