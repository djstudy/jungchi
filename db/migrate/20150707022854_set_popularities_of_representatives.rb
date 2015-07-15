class SetPopularitiesOfRepresentatives < ActiveRecord::Migration
  def up
    named = ["박지원", "문재인", "안철수", "김한길",  "이정현", "유승민", "나경원", "최경환","이완구","김무성"]
    Representative.all.each do |r|
      if(named.include?(r.name))
        r.update(popularity: "high")
        r.save
      else
        r.update(popularity: "low")
        r.save
      end
    end
  end
  def down
    Representative.all.update_all(popularity: nil)
  end
end
