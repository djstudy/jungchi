class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.integer :r_id
      t.string :name
      t.string :email
      t.string :party
      t.string :area
      t.integer :combo
      t.timestamps null: false
    end
  end
end
