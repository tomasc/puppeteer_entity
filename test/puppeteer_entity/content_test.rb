# frozen_string_literal: true

require "test_helper"

class PuppeteerEntity::ContentTest < Minitest::Test
  def test_content
    args = { url: "https://www.example.com" }
    entity = PuppeteerEntity::Content.new(args)

    response = entity.response

    assert_instance_of HTTP::Response, response
    assert_equal 200, response.status
    assert_equal "text/html", response.content_type.mime_type
    assert_includes response.body.to_s, "This domain is for use in illustrative examples in documents."
  end
end
