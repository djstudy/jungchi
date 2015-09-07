class StripPartyNameFromRepresentative < ActiveRecord::Migration
  def change
    Representative.all.each do |r|
      r.update(:party => r.party.strip)
    end
  end
end
