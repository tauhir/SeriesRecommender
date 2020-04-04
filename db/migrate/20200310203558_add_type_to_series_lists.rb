class AddTypeToSeriesLists < ActiveRecord::Migration[6.0]
  def change
    add_column :series_lists, :search_type, :boolean
  end
end
