class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.belongs_to :toilet, index: true

      t.timestamps null: false
    end
  end
end
