# frozen_string_literal: true
require "test_helper"

class PuppeteerEntityTest < Minitest::Test
  def setup
    # Add any setup code here
  end

  def test_that_it_has_a_version_number
    refute_nil ::PuppeteerEntity::VERSION
  end

  def test_response_method_raises_not_implemented_error
    entity = PuppeteerEntity.new
    assert_raises(NotImplementedError) do
      entity.response
    end
  end
end
