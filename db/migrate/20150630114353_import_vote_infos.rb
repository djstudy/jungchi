require 'csv'

class ImportVoteInfos < ActiveRecord::Migration
  def up
    VoteInfo.destroy_all


    csv_text = File.read('public/vote_info.csv')
    csv = CSV.parse(csv_text, :headers=>true)
    csv.each do |row|
      row["content"].gsub!("<br/>", "\n") if row["content"]
      row["content_plus"].gsub!("<br/>", "\n") if row["content_plus"]
      VoteInfo.create!(row.to_hash)
    end
  end
  def down
    VoteInfo.destroy_all
  end
end
