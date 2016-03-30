class Toilet < ActiveRecord::Base

    has_many :positions
    has_and_belongs_to_many :tags
    belongs_to :creator

    validates :name,        presence: true, length: {within: 3..100}
    validates :description, presence: true, length: {within: 5..100}
    validates :creator_id,  presence: true
end
