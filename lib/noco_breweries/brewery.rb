require 'pry'

class NocoBreweries::Brewery

  attr_accessor :name, :town, :description, :menu, :hours, :address, :phone_number, :website, :foco_brewery_guide_url

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @@all << self
  end

end
