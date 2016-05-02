require "pry"
require "nokogiri"
require "open-uri"


class NocoBreweries::Scraper

  def self.site
    Nokogiri::HTML(open("http://fortcollinsbreweryguide.com/breweries.aspx"))
  end

  def self.scrape_towns
    doc = Nokogiri::HTML(open("http://fortcollinsbreweryguide.com/breweries.aspx"))
    fort_collins = doc.css("#ctl00_MainContent_LocationsRepeater_ctl00_CityLabel").text
    berthoud = doc.css("#ctl00_MainContent_LocationsRepeater_ctl02_CityLabel").text
    greeley = doc.css("#ctl00_MainContent_LocationsRepeater_ctl04_CityLabel").text
    loveland = doc.css("#ctl00_MainContent_LocationsRepeater_ctl06_CityLabel").text
    windsor = doc.css("#ctl00_MainContent_LocationsRepeater_ctl08_CityLabel").text
    towns = [fort_collins, greeley, loveland, windsor, berthoud]
    towns.each {|town| NocoBreweries::Town.new(town)}
  end

  def self.scrape_breweries
    # brewery name: site.css("a h3").text.strip
    # brewery foco site url: site.css("td.content a") also you have to add fortcollinsbreweryguide.com/ and then the site
    site.css("td.content").each do |name|
      brewery = NocoBreweries::Brewery.new(name.css("a h3").text.strip)
      brewery.foco_brewery_guide_url = "http://fortcollinsbreweryguide.com/#{name.css("a").attribute("href").value}"
    end
  end

  def scrape_details #this might take in a brewery object as an argument
    # I might also have the cli call this method after the user has selected a brewery to then populate the details.
    # This is going to scrape the individual brewery site on fortcollinsbreweryguide.com
  end

end
