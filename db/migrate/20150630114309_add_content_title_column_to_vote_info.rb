class AddContentTitleColumnToVoteInfo < ActiveRecord::Migration
  def change
    add_column :vote_infos, :content_title, :string
  end
end
