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
    @@all.find {|town| town.include?(name)} || self.new(name)
  end

end
