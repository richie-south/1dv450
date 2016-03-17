class User < ActiveRecord::Base
    has_many :applikations
    has_secure_password

    validates :user_name,
              :presence => {:message => "du måste ange att okej namn"},
              :length => {:minimum => 3, :message => "namnet måste vara minst 3 tecken långt" },
              uniqueness: true
end
