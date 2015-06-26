require 'csv'

class ImportVotes < ActiveRecord::Migration
  def change
    Vote.destroy_all
    VoteResult.destroy_all
    result_name_eng = ["chanseong", "bandae", "gigwon", "boolcham", "chooljang", "cheongga", "gyeolseok"]

    remove_column :votes, :v_id
    csv_text = File.read('public/vote_results_refined.csv')
    csv = CSV.parse(csv_text, :headers=>true)
    csv.each do |row|
      v_id = row[1].to_i
      v_date = row[0].to_date
      v_title = row[2]
      Vote.create!(:id=>v_id, :voted_date=>v_date, :title=>v_title)



      for i in 0..6
        rep_id_arr = row[12+i].split(";")
        rep_id_arr.each do |a_rep_id|
          if (a_rep_id.length == 0 || a_rep_id.to_i == 0)
            next
          else
            VoteResult.create!(:representative_id=>a_rep_id.to_i, :vote_id=>v_id, :result=>result_name_eng[i])
          end
        end
        
      end


        
      


    end
  end
end
