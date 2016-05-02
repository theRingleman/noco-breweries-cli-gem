require 'pry'

class NocoBreweries::Brewery

  attr_accessor :name, :town

  @@all = ["Big Beaver Brewing", "Equinox Brewing", "Weldwerks Brewing Company", "Left Hand Brewing Company", "Upslope Brewing Company", "Rock Cut Brewing Company"]

  def self.all
    @@all
  end

  def initialize

  end

end
