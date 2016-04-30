require 'pry'

class NocoBreweries::CLI

  def call
    puts "Please choose a town in Northern Colorado and we will provide you with a list of breweries!"
    list_towns
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

end
