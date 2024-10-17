# frozen_string_literal: true

require "test_helper"
require "pdf-reader"

class PuppeteerEntity::PdfTest < Minitest::Test
  def test_pdf
    args = { url: "https://www.example.com" }
    entity = PuppeteerEntity::Pdf.new(args)

    response = entity.response

    assert_instance_of HTTP::Response, response
    assert_equal 200, response.status
    assert_equal "application/pdf", response.content_type.mime_type
    assert_not_empty response.body.to_s
    body_string = response.body.to_s
    assert_equal "%PDF-", body_string[0, 5]
    assert_match (/%EOF\s*\z/), body_string
    assert body_string.bytesize.between?(1000, 10_000_000)
  end

  def test_raises_error_when_url_is_invalid
    args = { url: "https://www.example.io/not-found" }
    entity = PuppeteerEntity::Pdf.new(args)

    assert_raises(PuppeteerEntity::RequestError) do
      entity.response
    end
  end

  def test_pdf_with_header_and_footer
    args = {
      url: "https://www.example.com",
      options: {
        display_header_footer: true,
        header_template: "<div style='font-size: 10px;'>Page <span class='pageNumber'></span> of <span class='totalPages'></span></div>",
        footer_template: "<div style='font-size: 10px;'>Footer</div>",
        margin: {
          top: "1cm",
          bottom: "1cm"
        }
      }
    }
    entity = PuppeteerEntity::Pdf.new(args)

    response = entity.response
    pdf_content = PDF::Reader.new(StringIO.new(response.body.to_s))

    assert_equal 200, response.status
    assert_equal "application/pdf", response.content_type.mime_type
    assert_match (/Page 1 of \d+/), pdf_content.pages.first.text
    assert_match (/Footer/), pdf_content.pages.first.text
  end
end
