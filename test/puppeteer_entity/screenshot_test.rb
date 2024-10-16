# frozen_string_literal: true
require "test_helper"

class PuppeteerEntity::ScreenshotTest < Minitest::Test
  def test_screenshot_filename
    args = { url: Faker::Internet.url }
    entity = PuppeteerEntity::Screenshot.new(args)
    filename = entity.filename

    assert_predicate filename, :present?
  end

  def test_screenshot_id
    url = "https://now-staging.gsd.harvard.edu/calendar/academic-calendar?filters%5Ball_academic_calendar%5D=0&filters%5Ball_academic_calendar%5D=1&filters%5Bacademic_calendar%5D%5B%5D=&filters%5Ball_events%5D=0&filters%5Ball_events%5D=1&filters%5Bevents%5D%5B%5D=&expanded%5Breviews%5D=1&filters%5Ball_reviews%5D=0&filters%5Breviews%5D%5B%5D=&filters%5Ball_affiliations%5D=0&filters%5Ball_affiliations%5D=1&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Barch_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Blarch_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bupd_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bother_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Boffice_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bstudent_affiliations%5D%5B%5D=&filters%5Ball_audiences%5D=0&filters%5Ball_audiences%5D=1&filters%5Baudiences%5D%5B%5D="
    args = { url: url }
    entity = PuppeteerEntity::Screenshot.new(args)
    filename = entity.filename
    id = entity.id

    assert_predicate id, :end_with?, filename
    assert_equal({ browserless_url: ENV["BROWSERLESS_URL"], retry_limit: 3, url: url }, PuppeteerEntity::Screenshot.from_id(id).to_h)
  end

  def test_screenshot_derivation_url
    args = { url: Faker::Internet.url }
    entity = PuppeteerEntity::Screenshot.new(args)

    assert_respond_to entity, :derivation_url
  end

  def test_screenshot_download_url
    custom_filename = File.basename(Faker::File.file_name)
    args = { url: Faker::Internet.url }
    entity = PuppeteerEntity::Screenshot.new(args)

    assert_includes entity.download_url(filename: custom_filename), custom_filename
  end

  def test_png_screenshot
    args = { url: "https://www.example.com", options: { type: :png } }
    entity = PuppeteerEntity::Screenshot.new(args)

    entity.file.refresh_metadata!
    entity.refresh_metadata!

    assert_equal %w[filename height mime_type size width], entity.file.metadata.keys.sort
    assert_predicate entity.file.metadata["filename"], :present?
    assert_equal "image/png", entity.file.metadata["mime_type"]
    assert_equal 800, entity.file.metadata["width"]
    assert_equal 600, entity.file.metadata["height"]
    assert_operator entity.file.metadata["size"], :>, 1_000
    assert_equal "image/png", entity.file.mime_type
    assert_operator entity.file.size, :>, 0
  end

  def test_jpeg_screenshot
    args = { url: "https://www.example.com", options: { type: :jpeg, quality: 80 } }
    entity = PuppeteerEntity::Screenshot.new(args)

    entity.file.refresh_metadata!
    entity.refresh_metadata!

    assert_equal %w[filename height mime_type size width], entity.file.metadata.keys.sort
    assert_predicate entity.file.metadata["filename"], :present?
    assert_equal "image/jpeg", entity.file.metadata["mime_type"]
    assert_equal 800, entity.file.metadata["width"]
    assert_equal 600, entity.file.metadata["height"]
    assert_operator entity.file.metadata["size"], :>, 1_000
    assert_equal "image/jpeg", entity.file.mime_type
    assert_operator entity.file.size, :>, 0
  end
end
