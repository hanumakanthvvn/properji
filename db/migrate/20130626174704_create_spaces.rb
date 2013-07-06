class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.references :user
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.timestamps
    end
  end
end
