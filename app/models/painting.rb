class Painting < ActiveRecord::Base
  include PgSearch
  attr_accessor :painting_url
  attr_accessible :artist, :address, :painting_url, :name, :image, :museum, :museum_id
  
  belongs_to :artist
  belongs_to :museum
  has_attached_file :image, 
    :styles => {:thumb => "200x200#"},
    :path => "painting/:attachment/:style/:id.:extension",
    :convert_options => { :thumb => '-quality 75 -strip -interlace Line' }
  
  validates_presence_of :museum_id
  
  scope :mappable, where("museum_id is NOT NULL")
  pg_search_scope :search_by_artist, 
                  :associated_against => { :artist => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}


end
