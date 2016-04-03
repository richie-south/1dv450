class Position < ActiveRecord::Base

    belongs_to :toilets

    validates :address, presence: true, length: {within: 4..100}
    validates :toilet_id, presence: true

    geocoded_by :address
    after_validation :geocode,
                     :if => lambda{ |obj| obj.address_changed? }
end
