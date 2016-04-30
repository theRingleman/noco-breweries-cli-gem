require 'pry'

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
    puts "Please choose a town and we will provide you with a list of breweries!"
    input = gets.strip.downcase
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
      puts "Sorry but please select from a list of the following towns"
      list_towns
    end
  end

end
