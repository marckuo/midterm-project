class Match < ActiveRecord::Base
  
  has_many   :reviews
  belongs_to :user
  validates  :sport_id, presence: true

end

