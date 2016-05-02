# require "pry"

class NocoBreweries::CLI

  def call
    puts "Welcome to Northern Colorado Brewies!"
    scrape
    menu
  end

  def menu
    # TODO there needs to be a prompt that tells the user what their options are every time. At least make it more clear
    # TODO also make sure to add in a goodbye when the user types exit
    greeting = "Please choose a town and we will provide you with a list of breweries or type exit."
    puts greeting
    NocoBreweries::Town.list_towns
    input = gets.strip.downcase
    while input != "exit"
      cities_case(input)
      NocoBreweries::Town.list_towns
      input = gets.strip.downcase
    end
  end

  def scrape
    NocoBreweries::Scraper.new.class.scrape_towns
  end

  def cities_case(input)
    case input
    when "loveland"
      puts "Big Beaver Brewing"
    when "fort collins"
      puts "Equinox Brewing"
    when "greeley"
      puts "Weldwerks Brewing Company"
    when "longmont"
      puts "Left Hand Brewing Company"
    when "boulder"
      puts "Upslope Brewing Company"
    when "estes park"
      puts "Rock Cut Brewing Company"
    when "exit"
      puts "Thanks for checking out the Northern Colorado Brewing Scene! Have a great day!"
    else
      puts "Sorry but please select from a list of the following towns, or type in exit to quit the program."
    end
  end

end
