class Match < ActiveRecord::Base
  
  has_many   :reviews
  # belongs_to :user
  belongs_to :sports
  validates  :sport_id, presence: true


  def player_one
    User.find_by(id: player_one_id)
  end

  def player_two
    User.find_by(id: player_two_id)
  end
end

