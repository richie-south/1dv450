class Applikation < ActiveRecord::Base
    belongs_to :user

    validates :app_name,
              :presence => {:message => "du måste ange att okej namn"},
              :length => {:minimum => 3, :message => "namnet måste vara minst 3 tecken långt" }
end
