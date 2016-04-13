class ToiletsTags < ActiveRecord::Migration
  def change
      create_table :tags_toilets, id: false do |t|
          t.belongs_to :toilet, index: true
          t.belongs_to :tag, index: true
          
      end
  end
end
