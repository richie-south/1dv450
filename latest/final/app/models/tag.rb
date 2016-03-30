class Tag < ActiveRecord::Base
    has_and_belongs_to_many :toilets

    validates :name, presence: true, length: {within: 1..25}
end
