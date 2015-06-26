require 'csv'

class ImportRepresentatives < ActiveRecord::Migration
  def change
    Representative.destroy_all
    remove_column :representatives, :r_id
    csv_text = File.read('public/representatives.csv')
    csv = CSV.parse(csv_text, :headers=>true)
    csv.each do |row|
      Representative.create!(row.to_hash)
    end
  end
end
