# frozen_string_literal: true
require "test_helper"

class PuppeteerEntity::PdfTest < Minitest::Test
  def test_pdf
    args = { url: "https://www.example.com" }
    entity = PuppeteerEntity::Pdf.new(args)

    entity.file.refresh_metadata!
    entity.refresh_metadata!

    assert_equal %w[filename height mime_type page_count page_dimensions page_numbers page_rotations size width], entity.file.metadata.keys.sort
    assert_predicate entity.file.metadata["filename"], :present?
    assert_equal "application/pdf", entity.file.metadata["mime_type"]
    assert_equal 1, entity.file.metadata["page_count"]
    assert_equal [[215.89999999999998, 279.4]], entity.file.metadata["page_dimensions"]
    assert_equal [1], entity.file.metadata["page_numbers"]
    assert_equal [0.0], entity.file.metadata["page_rotations"]
    assert_equal 612, entity.file.metadata["width"]
    assert_equal 792, entity.file.metadata["height"]
    assert_operator entity.file.metadata["size"], :>, 1_000
    assert_equal "application/pdf", entity.file.mime_type
    assert_operator entity.file.size, :>, 0
  end
end
