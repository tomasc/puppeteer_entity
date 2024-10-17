# frozen_string_literal: true

require "test_helper"

class PuppeteerEntity::ScreenshotTest < Minitest::Test
  def test_screenshot
    args = { url: "https://example.com" }
    entity = PuppeteerEntity::Screenshot.new(args)

    response = entity.response

    assert_instance_of HTTP::Response, response
    assert_equal 200, response.status
    assert_equal "image/png", response.content_type.mime_type
    assert_not_empty response.body.to_s
    body_string = response.body.to_s
    assert_equal "\x89PNG\r\n\x1A\n".b, body_string[0..7]
    assert body_string.bytesize.between?(1000, 10_000_000)
  end

  def test_jpeg_screenshot
    args = { url: "https://www.example.com", options: { type: :jpeg, quality: 80 } }
    entity = PuppeteerEntity::Screenshot.new(args)

    response = entity.response

    assert_instance_of HTTP::Response, response
    assert_equal 200, response.status
    assert_equal "image/jpeg", response.content_type.mime_type
    assert_not_empty response.body.to_s
    body_string = response.body.to_s
    assert_equal "\xFF\xD8\xFF\xE0".b, body_string[0..3]
    assert body_string.bytesize.between?(1000, 10_000_000)
  end
end
