class Space < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :address, :latitude, :longitude, :space_type, :accommodates, :size, :location, :city, :state, :zip_code, :wifi, :ac,
                  :conference_room, :window, :kitchen, :printer, :parking
  belongs_to :user

  SPACE_TYPES = ["Office Space","Meeting Room", "Desk"]

  scope :address_like, lambda{|value| where("address like ?","%#{value}%")}
  
   def gmaps4rails_address
       "#{location},#{city}, #{state}"
   end

   def gmaps4rails_infowindow
      "<h4>#{space_type}</h4>" << "<h4>#{address}</h4>"
   end


  def gmaps4rails_marker_picture
   {
   "picture" => "/assets/marker.png",
   "width" => "20",
   "height" => "39",
   }
  end
end
