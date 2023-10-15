class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :country
      t.text :address
      t.text :description
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
