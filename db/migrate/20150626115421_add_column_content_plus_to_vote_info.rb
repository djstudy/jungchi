class AddColumnContentPlusToVoteInfo < ActiveRecord::Migration
  def change
    add_column :vote_infos, :content_plus, :text
  end
end
