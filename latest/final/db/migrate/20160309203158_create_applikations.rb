class CreateApplikations < ActiveRecord::Migration
  def change
    create_table :applikations do |t|
      t.references :user
      t.string "app_name", :limit => 20, null: false
      t.string "appkey", null: false
      t.timestamps null: false
    end
  end
end
