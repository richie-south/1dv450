class CreateApplikations < ActiveRecord::Migration
  def change
    create_table :applikations do |t|

      t.timestamps null: false
    end
  end
end
