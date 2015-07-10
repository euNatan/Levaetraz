class Map < ActiveRecord::Base
  has_many :routes
  has_many :places
end
