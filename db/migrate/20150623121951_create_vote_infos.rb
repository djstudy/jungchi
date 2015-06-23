class CreateVoteInfos < ActiveRecord::Migration
  def change
    create_table :vote_infos do |t|
      t.integer :vote_id
      t.string :info_type
      t.integer :sequence
      t.text  :content
      t.integer :speaker_id
      t.timestamps null: false
    end
  end
end
