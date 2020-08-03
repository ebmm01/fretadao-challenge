require 'test_helper'

class ScrapperTest < ActiveSupport::TestCase
  test "Must correct initialize class" do
    scrapper = Services::Scrapper.new("https://github.com/ebmm01")
    
    assert_not_nil scrapper
  end

  test "Must correct initialize class even with" do
    scrapper = Services::Scrapper.new("https://github.com/ebmm01")
    
    assert_not_nil scrapper
  end

  test "Must verify that user exists" do
    scrapper = Services::Scrapper.new("https://github.com/ebmm01")

    assert scrapper.check_user_existence
  end

  test "Must verify that user doesn't exists" do
    scrapper = Services::Scrapper.new("https://github.com/ebmm02")

    assert_not scrapper.check_user_existence
  end

  test "Must get correct user name" do
    scrapper = Services::Scrapper.new("https://github.com/ebmm01")

    assert_equal scrapper.get_user_name, "Elias Bernardo"
  end
end
    