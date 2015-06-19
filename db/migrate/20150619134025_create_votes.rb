class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.date :voted_date
      t.integer :v_id
      t.string :title
      t.timestamps null: false
    end
  end
end
