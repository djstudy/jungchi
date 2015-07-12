class SetPopularitiesOfRepresentatives < ActiveRecord::Migration
  def up
    named = ["장하나", "박지원", "문재인", "박영선", "안철수", "김한길", "우윤근", "문희상", "이정현", "유승민", "나경원", "최경환","이완구","서청원","김무성","주호영"]
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

  end
end
