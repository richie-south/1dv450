class CreateToilets < ActiveRecord::Migration
  def change
    create_table :toilets do |t|
      t.string :name
      t.string :description
      t.belongs_to :creator, index: true

      t.timestamps null: false
    end
  end
end
