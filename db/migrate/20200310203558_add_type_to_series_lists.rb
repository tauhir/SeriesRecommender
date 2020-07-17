class AddTypeToSeriesLists < ActiveRecord::Migration[6.0]
  def change
    add_column :series_lists, :list_type, :integer
  end
end
