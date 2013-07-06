class Space < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :address, :latitude, :longitude, :name
  belongs_to :user

  scope :address_like, lambda{|value| where("address like ?","%#{value}%")}
  
   def gmaps4rails_address
       address
   end

   def gmaps4rails_infowindow
      "<h4>#{name}</h4>" << "<h4>#{address}</h4>"
   end

  def gmaps4rails_marker_picture
   {
   "picture" => "/assets/marker.png",
   "width" => "20",
   "height" => "39",
   }
  end
end
