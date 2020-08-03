require 'test_helper'

class ScrapperTest < ActiveSupport::TestCase
  test "Must correct shorten URL" do
    shortenURL = Services::URLHandler.shorten("https://github.com/ebmm01")
    
    assert_equal shortenURL, "http://tinyurl.com/y35283p2"
  end
  
  test "Must correct expand URL" do
    url = "https://github.com/ebmm01"
    shortenURL = Services::URLHandler.shorten(url)
    expandedURL = Services::URLHandler.unshorten(shortenURL)
    
    assert_equal expandedURL, url
  end
end
    