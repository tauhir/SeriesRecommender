class AddTypeToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :type, :boolean
  end
end
