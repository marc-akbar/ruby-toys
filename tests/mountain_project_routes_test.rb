require File.join(File.dirname(__FILE__), '..', 'web_scrapping_mp/mountain_project_routes.rb')
require 'test/unit'

class TestMPWebScrapping < Test::Unit::TestCase

  def test_openning_a_webpage
    html = "https://www.example.com"
    doc = Nokogiri::HTML(open(html))

    assert_equal "Example Domain", doc.title
  end

  def test_finding_text
    html = "https://www.example.com"
    doc = Nokogiri::HTML(open(html))
    text = doc.css('body div p:last-child').text

    assert_equal "More information...", text
  end

  def test_storing_elements_in_a_hash
    html = "https://moz.com/top500"
    doc = Nokogiri::HTML(open(html))
    domains = doc.css('#top-500-domains table tbody tr td a')
    websites = {}

    domains.each do |domain|
      websites[domain.text] = domain['href']
    end

    assert_equal 500, websites.length
  end

end
