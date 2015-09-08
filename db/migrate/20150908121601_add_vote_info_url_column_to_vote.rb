class AddVoteInfoUrlColumnToVote < ActiveRecord::Migration
  def up
    add_column :votes, :vote_info_url, :string
    Vote.reset_column_information
    url = %w{http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_O1N2E0W9R1Z0B1M8O0U9V4V1L7J7G5 http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_H1I2L1Y0I0H4E1C1N0T2Q0Z9J3A4N0 http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_P1J2G1Z1G2Q1V0E0F5W8U3L8Z6P7L5 http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_K1U4X0T2X2G7C0Q0I4Q0M4D3U6N1A2 http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_M1E4D1Q1Z1D3N2C1I1B2Z5N8A2Y5Y2 http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=PRC_G1X5A0A2E2W4T1P9W4R3R1E0P8L9Y5}
    Vote.order(:id).each_with_index do |vote, index|
      vote.update(vote_info_url: url[index])
    end
  end
  def down
    remove_column :votes, :vote_info_url
  end
end
