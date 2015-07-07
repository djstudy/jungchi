class AddPopularityColumnToRepresentative < ActiveRecord::Migration
  def change
    add_column :representatives, :popularity, :string
  end
end
