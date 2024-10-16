# frozen_string_literal: true
require "test_helper"

class PuppeteerEntity::ContentTest < Minitest::Test
  def test_content
    args = { url: "https://www.example.com" }
    entity = PuppeteerEntity::Content.new(args)

    entity.file.refresh_metadata!
    entity.refresh_metadata!

    assert_equal %w[filename height mime_type size width], entity.file.metadata.keys.sort
    assert_predicate entity.file.metadata["filename"], :present?
    assert_equal "text/html", entity.file.metadata["mime_type"]
    assert_nil entity.file.metadata["width"]
    assert_nil entity.file.metadata["height"]
    assert_operator entity.file.metadata["size"], :>, 1_000
    assert_equal "text/html", entity.file.mime_type
    assert_operator entity.file.size, :>, 0
  end
end
