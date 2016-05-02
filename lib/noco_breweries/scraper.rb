require "pry"
require "nokogiri"
require "open-uri"


class NocoBreweries::Scraper

  def self.scrape_towns
    doc = Nokogiri::HTML(open("http://www.coloradocraftbrews.com/colorado-breweries/"))
    # Brewery name and town: doc.css("p strong")[5].text
    # Brewery Website: doc.css("p strong a").attribute("href").value
    binding.pry
  end

  def self.scrape_breweries

  end

end
