require "launchy"

class NocoBreweries::CLI

  def call
    puts "Welcome to Northern Colorado Breweries!"
    scrape
    menu
  end

  def menu
    choose_town
    input = gets.strip.downcase
    if input != "exit"
      if town = NocoBreweries::Town.find_by_name(input)
        town.list_breweries
        puts "Please select a brewery by name or type back to go back to the town selection."
        brewery_choice
        menu
      else
        puts "Sorry, we have no such town!"
        menu
      end
    end
  end

  def brewery_choice
    brewery_selection = "Please select another brewery, or type open to view this breweries website, or type back to go back to the towns."
    selection = gets.strip.downcase
    while selection != "back"
      if @brewery = NocoBreweries::Brewery.find_by_name(selection)
        print_brewery_info
        puts brewery_selection
        selection = gets.strip
      elsif selection == "open"
        Launchy.open(brewery.website)
        puts brewery_selection
        selection = gets.strip
      else
        puts "Please type in a valid brewery or type \"back\" to go back to the town selection"
        town.list_breweries
        selection = gets.strip
      end
    end
  end

  def scrape
    NocoBreweries::Scraper.scrape_towns
    NocoBreweries::Scraper.scrape_breweries
    NocoBreweries::Scraper.scrape_details
  end

  def print_brewery_info
    puts @brewery.description
    puts @brewery.menu
    puts @brewery.address
    puts @brewery.phone_number
    puts @brewery.website
  end

  def choose_town
    NocoBreweries::Town.list_towns
    puts "Please choose a town and we will provide you with a list of breweries or type exit."
  end

end
