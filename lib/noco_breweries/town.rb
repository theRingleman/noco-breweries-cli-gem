require "pry"

class NocoBreweries::Town

  @@all = []

  attr_accessor :name, :breweries

  def initialize(name)
    @name = name
    @breweries = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_towns
    @@all.each_with_index do |town, index|
      if index == @@all.length - 1
        print " #{town.name}\n"
      else
        print "#{town.name} - "
      end
    end
  end

  def self.find_or_create_by_name(name)
    @@all.find {|town| town.name.include?(name)} || self.new(name)
  end

  def self.find_by_name(name)
    @@all.find {|town| town.name.downcase.include?(name)}
  end

  def list_breweries
    @breweries.each_with_index {|brewery, index| puts "#{index + 1}: #{brewery.name}"}
  end

end
