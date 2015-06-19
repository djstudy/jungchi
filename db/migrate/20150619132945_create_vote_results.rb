class CreateVoteResults < ActiveRecord::Migration
  def change
    create_table :vote_results do |t|
      t.integer :representative_id
      t.integer :user_id
      t.integer :vote_id
      t.string :result
      t.timestamps null: false
    end
  end
end
