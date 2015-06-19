class InsertTempUserData < ActiveRecord::Migration
  def change
  	(1..6).to_a.each do |index|
      User.create(email: "dummy_user#{index}@dummy.com")
    end
  end
end
