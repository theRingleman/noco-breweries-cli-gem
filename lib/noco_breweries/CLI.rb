# require 'pry'

class NocoBreweries::CLI

  def call
    puts "Welcome to Northern Colorado Brewies!"
    list_towns
    menu
  end

  def list_towns
    # This will eventually be scraped from http://coloradofrontrange.com/
    towns = ["Fort Collins", "Loveland", "Boulder", "Estes Park", "Greeley", "Longmont"]
    towns.sort.each_with_index do |town, index|
      if index == towns.length - 1
        print " #{town}\n"
      else
        print "#{town} - "
      end
    end
  end

  def menu
    # TODO there needs to be a prompt that tells the user what their options are every time. At least make it more clear
    # TODO also make sure to add in a goodbye when the user types exit
    puts "Please choose a town and we will provide you with a list of breweries!"
    input = gets.strip.downcase
    while input != "exit"
      cities_case(input)
      list_towns
      input = gets.strip.downcase
    end
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
    else
      puts "Sorry but please select from a list of the following towns, or type in exit to quit the program."
    end
  end

end
