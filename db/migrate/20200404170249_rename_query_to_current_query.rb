class RenameQueryToCurrentQuery < ActiveRecord::Migration[6.0]
  def change
    rename_column :searches, :query, :current_query
  end
end
