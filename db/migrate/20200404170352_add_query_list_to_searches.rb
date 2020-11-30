class AddQueryListToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :query_list, :string, array: true, default: []
  end
end
