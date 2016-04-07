class Creator < ActiveRecord::Base
    has_many :toilets
    has_secure_password

    validates :name,
              :presence => {:message => "du måste ange att okej namn"},
              :length => {:minimum => 3, :message => "namnet måste vara minst 3 tecken långt" },
              uniqueness: true

end
