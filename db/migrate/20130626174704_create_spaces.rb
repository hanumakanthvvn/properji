class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.references :user
      t.string :space_type
      t.string :accommodates
      t.string :size
      t.boolean :wifi
      t.boolean :conference_room
      t.boolean :kitchen
      t.boolean :window
      t.boolean :parking
      t.boolean :ac
      t.boolean :printer
      t.string :address
      t.string :location
      t.string :city
      t.string :state
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.timestamps
    end
  end
end
