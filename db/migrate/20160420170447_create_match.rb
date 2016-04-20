class CreateMatch < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :created_at
      t.string   :address
      t.integer  :player_one_id
      t.integer  :player_two_id
      t.integer  :sport_id
    end
  end
end
