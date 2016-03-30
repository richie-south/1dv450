class ToiletsTags < ActiveRecord::Migration
  def change
      create_table :toilets_tags, id: false do |t|
          t.belongs_to :toilet, index: true
          t.belongs_to :tag, index: true
      end
  end
end
