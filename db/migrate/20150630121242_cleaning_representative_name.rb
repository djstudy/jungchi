class CleaningRepresentativeName < ActiveRecord::Migration
  def up
    Representative.all.each do |r|
      r.update(name: r.name.gsub(" ",""))
    end
  end

  def down

  end
end
