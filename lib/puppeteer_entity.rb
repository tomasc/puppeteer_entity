# frozen_string_literal: true

require "active_support/gzip"
require "dry/initializer"
require "dry/transformer"
require "http"
require "universalid"

require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.tag = File.basename(__FILE__, ".rb")
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.dirname(__FILE__))

module PuppeteerEntity
  class Error < StandardError; end

  class RequestError < Error; end

  class IdLengthError < Error; end
end
