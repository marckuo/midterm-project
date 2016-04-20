class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.datetime :created_at
      t.integer  :rating
      t.integer  :from_user_id
      t.integer  :to_user_id
      t.string   :comments
      t.integer  :match_id
    end
  end
end
