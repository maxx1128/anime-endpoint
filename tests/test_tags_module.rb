require "test/unit"
require_relative '../lib/tags_module.rb'

class TestTagsModuleQuery < Test::Unit::TestCase
  include Tags

  def test_tags_have_core_params
    core_params = tag_parameters([])

    assert_equal(true, core_params.include?('+height%3a>1000+height%3a<4000+width%3A>750'))
    assert_equal(true, core_params.include?('+-comic+-translation_request'))
  end
end
