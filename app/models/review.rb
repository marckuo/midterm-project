class Review < ActiveRecord::Base

  belongs_to :match

  validates  :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

  def reviewed_by_player
    User.find_by(id: from_user_id)
  end

  def reviewed_player
    User.find_by(id: to_user_id)
  end

end

