
module Idealista 
  class Property

    def initialize(options = {})
      @attributes = options
      # TODO create instance vars and attr_accessors with options hash
    end

    def self.parse(element_list)
      element_list.map do |p|
        Property.new(p)
      end
    end

  end
end


#class Property
  #attr_accessor :latitude, :longitude, :price, :address, :location, :url
  ##TODO choose either lat/long or location object to store that datta
  #def initialize(latitude = nil, longitude = nil, price = nil, address = nil, url = nil)
    #@price = price
    #@latitude = latitude
    #@longitude = longitude
    #@address = address
    #@url = url
    #if latitude and longitude
      #@location = Location.new([latitude, longitude])
    #else
      #@location = nil
    #end
  #end

  #def coordinates
    #[@latitude, @longitude]
  #end

  #def distance(coord)
    #Haversine.distance(coord, @location.coordinates).to_m
  #end

  #def print(location) # = nil
    #raise ArgumentError unless location.class.name == NilClass or Location
    #format = "dist: %-3dm %24s %5d %s"
    #puts format % [distance(location.coordinates).round(0), coordinates.join(", "), @price, @address]
  #end

  ##TODO distance as instance variable?

#end
