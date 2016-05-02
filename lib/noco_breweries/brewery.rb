require 'pry'

class NocoBreweries::Brewery

  attr_accessor :name, :town, :description, :menu, :hours, :address, :phone_number, :website

  @@all = []

  def self.all
    @@all
  end

  def initialize
    @@all << self
  end

end
