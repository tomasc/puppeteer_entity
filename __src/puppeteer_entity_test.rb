# frozen_string_literal: true

require "test_helper"

module Modulor
  class PuppeteerEntityTest < ActiveSupport::TestCase
    before(:each) { Shrine.storages[:puppeteer_store].clear! }

    describe "Screenshot" do
      describe "#filename" do
        let(:args) { { url: Faker::Internet.url } }
        let(:entity) { PuppeteerEntity::Screenshot.new(args) }
        let(:filename) { entity.filename }

        it { _(filename).must_be :present? }
      end
    end

    describe "#id" do
      let(:url) { "https://now-staging.gsd.harvard.edu/calendar/academic-calendar?filters%5Ball_academic_calendar%5D=0&filters%5Ball_academic_calendar%5D=1&filters%5Bacademic_calendar%5D%5B%5D=&filters%5Ball_events%5D=0&filters%5Ball_events%5D=1&filters%5Bevents%5D%5B%5D=&expanded%5Breviews%5D=1&filters%5Ball_reviews%5D=0&filters%5Breviews%5D%5B%5D=&filters%5Ball_affiliations%5D=0&filters%5Ball_affiliations%5D=1&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Barch_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Blarch_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bupd_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bother_prog_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Boffice_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bevent_affiliations%5D%5B%5D=&filters%5Baffiliations%5D%5Bstudent_affiliations%5D%5B%5D=&filters%5Ball_audiences%5D=0&filters%5Ball_audiences%5D=1&filters%5Baudiences%5D%5B%5D=" }
      let(:args) { { url: } }
      let(:entity) { PuppeteerEntity::Screenshot.new(args) }
      let(:filename) { entity.filename }
      let(:id) { entity.id }

      it { _(id).must_be :ends_with?, filename }
      it { _(PuppeteerEntity::Screenshot.from_id(id).to_h).must_equal({ browserless_url: ENV["BROWSERLESS_URL"], retry_limit: 3, url: }) }
    end

    describe "#derivation_url" do
      let(:args) { { url: Faker::Internet.url } }
      let(:entity) { PuppeteerEntity::Screenshot.new(args) }

      it { _(entity).must_respond_to :derivation_url }
    end

    describe "#download_url" do
      let(:custom_filename) { File.basename(Faker::File.file_name) }
      let(:args) { { url: Faker::Internet.url } }
      let(:entity) { PuppeteerEntity::Screenshot.new(args) }

      it { _(entity.download_url(filename: custom_filename)).must_include custom_filename }
    end

    describe "PNG" do
      let(:args) { { url: "https://www.example.com", options: { type: :png } } }
      let(:entity) { PuppeteerEntity::Screenshot.new(args) }

      # force file to be created & metadata assigned
      before do
        entity.file.refresh_metadata!
        entity.refresh_metadata!
      end

      it "stores the PNG" do
        _(entity.file.metadata.keys.sort).must_equal %w[filename height mime_type size width]
        _(entity.file.metadata["filename"]).must_be :present?
        _(entity.file.metadata["mime_type"]).must_equal "image/png"
        _(entity.file.metadata["width"]).must_equal 800
        _(entity.file.metadata["height"]).must_equal 600
        _(entity.file.metadata["size"]).must_be :>, 1_000
        _(entity.file.mime_type).must_equal "image/png"
        _(entity.file.size).must_be :>, 0
      end
    end

    describe "JPEG" do
      let(:args) { { url: "https://www.example.com", options: { type: :jpeg, quality: 80 } } }
      let(:entity) { PuppeteerEntity::Screenshot.new(args) }

      # force file to be created & metadata assigned
      before do
        entity.file.refresh_metadata!
        entity.refresh_metadata!
      end

      it "stores the JPEG" do
        _(entity.file.metadata.keys.sort).must_equal %w[filename height mime_type size width]
        _(entity.file.metadata["filename"]).must_be :present?
        _(entity.file.metadata["mime_type"]).must_equal "image/jpeg"
        _(entity.file.metadata["width"]).must_equal 800
        _(entity.file.metadata["height"]).must_equal 600
        _(entity.file.metadata["size"]).must_be :>, 1_000
        _(entity.file.mime_type).must_equal "image/jpeg"
        _(entity.file.size).must_be :>, 0
      end
    end

    describe "PDF" do
      let(:args) { { url: "https://www.example.com" } }
      let(:entity) { PuppeteerEntity::Pdf.new(args) }

      # force file to be created
      before do
        entity.file.refresh_metadata!
        entity.refresh_metadata!
      end

      it "stores the PDF" do
        _(entity.file.metadata.keys.sort).must_equal %w[filename height mime_type page_count page_dimensions page_numbers page_rotations size width]
        _(entity.file.metadata["filename"]).must_be :present?
        _(entity.file.metadata["mime_type"]).must_equal "application/pdf"
        _(entity.file.metadata["page_count"]).must_equal 1
        _(entity.file.metadata["page_dimensions"]).must_equal [ [ 215.89999999999998, 279.4 ] ]
        _(entity.file.metadata["page_numbers"]).must_equal [ 1 ]
        _(entity.file.metadata["page_rotations"]).must_equal [ 0.0 ]
        _(entity.file.metadata["width"]).must_equal 612
        _(entity.file.metadata["height"]).must_equal 792
        _(entity.file.metadata["size"]).must_be :>, 1_000
        _(entity.file.mime_type).must_equal "application/pdf"
        _(entity.file.size).must_be :>, 0
      end
    end

    describe "Content" do
      let(:args) { { url: "https://www.example.com" } }
      let(:entity) { PuppeteerEntity::Content.new(args) }

      # force file to be created
      before do
        entity.file.refresh_metadata!
        entity.refresh_metadata!
      end

      it "stores the HTML" do
        _(entity.file.metadata.keys.sort).must_equal %w[filename height mime_type size width]
        _(entity.file.metadata["filename"]).must_be :present?
        _(entity.file.metadata["mime_type"]).must_equal "text/html"
        _(entity.file.metadata["width"]).must_be_nil
        _(entity.file.metadata["height"]).must_be_nil
        _(entity.file.metadata["size"]).must_be :>, 1_000
        _(entity.file.mime_type).must_equal "text/html"
        _(entity.file.size).must_be :>, 0
      end
    end
  end
end
