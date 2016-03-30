class Creator < ActiveRecord::Base
    has_many :toilets

    has_secure_password

    validates :name, presence: true, length: {within: 3..100}
    validates :password, presence: true, length: {within: 6..100}
    validates :password_confirmation, presence: true
end
