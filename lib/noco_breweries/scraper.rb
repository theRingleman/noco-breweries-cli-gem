require "pry"
require "nokogiri"
require "open-uri"


class NocoBreweries::Scraper

  SITE = Nokogiri::HTML(open("http://fortcollinsbreweryguide.com/breweries.aspx"))


  def self.scrape_towns
    doc = SITE
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
    SITE.css("td.content").each do |name|
      brewery = NocoBreweries::Brewery.new(name.css("a h3").text.strip) # This gets the name of the Brewery
      # This gets the url for the webstie that is going to be scraped for more information
      brewery.foco_brewery_guide_url = "http://fortcollinsbreweryguide.com/#{name.css("a").attribute("href").value}"
    end
  end

  # def self.scrape_details #Nope this is going to have to take in an array of all the breweries to assign the towns to it. I would much rather set the town via the info online.
    # TODO See if I can find a way to scrape the town from the primary breweries site.
    # TODO I might also have the cli call this method after the user has selected a brewery to then populate the details.
    # This is going to scrape the individual brewery site on fortcollinsbreweryguide.com
    # Nokogiri::HTML(open(brewery.foco_brewery_guide_url)) this is what it will look like
    # doc = Nokogiri::HTML(open("http://fortcollinsbreweryguide.com/Brewery/Odell-Brewing-Company.aspx"))
    # brewery_info = doc.css("td.content").text.split(/\r\n/)
    # brewery description: brewery_info[0].strip
    # menu: brewery_info[1].strip
    # website: brewery_info.find {|item| item.include?("www")}.strip
    # phone_number: brewery_info.find {|item| item.include?("970")}.strip
    # address: brewery_info.grep(/\d{1,5}\s\w+\s\w+\s\w+/).find {|item| item.strip.split(" ").length < 6}.strip
    # I think that I am going to have to use the array of towns from the above method to iterate through and set the breweries town to that.
    # something like NocoBreweries::Town.all do |town|
      # if brewery_info.include?(town.name)
        # brewery.town = town
      # end
    # end
    # binding.pry
  # end

  def self.scrape_details
    NocoBreweries::Brewery.all.each do |brewery|
      doc = Nokogiri::HTML(open(brewery.foco_brewery_guide_url))
      brewery_info = doc.css("td.content").text.split(/\r\n/)
      brewery.description = brewery_info[0].strip
      brewery.menu = brewery_info[1].strip
      brewery.website = brewery_info.find {|item| item.include?("www")}.strip unless brewery_info.find {|item| item.include?("www")} == nil
      brewery.phone_number = brewery_info.find {|item| item.include?("970")}.strip unless brewery_info.find {|item| item.include?("970")} == nil
      brewery.address = brewery_info.grep(/\d{1,5}\s\w+\s\w+\s\w+/).find {|item| item.strip.split(" ").length < 6}.strip unless brewery_info.grep(/\d{1,5}\s\w+\s\w+\s\w+/).find {|item| item.strip.split(" ").length < 6} == nil
      NocoBreweries::Town.all.each do |town|
        if brewery_info.find {|info| info.include?(town.name)}
          brewery.town = town
          town.breweries << brewery
        end
      end
    end
  end

end
