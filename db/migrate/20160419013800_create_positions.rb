class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.string :latitude
      t.string :longitude
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
