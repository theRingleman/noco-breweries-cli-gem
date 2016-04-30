# require "pry"

class NocoBreweries::Town

  @@towns = ["Fort Collins", "Loveland", "Boulder", "Estes Park", "Greeley", "Longmont"]

  attr_accessor :name, :breweries

  def initialize(name)
    @name = name
    @breweries = []
    @@towns << self
  end

  def self.list_towns
    @@towns.sort.each_with_index do |town, index|
      if index == @@towns.length - 1
        print " #{town}\n"
      else
        print "#{town} - "
      end
    end
  end

end
