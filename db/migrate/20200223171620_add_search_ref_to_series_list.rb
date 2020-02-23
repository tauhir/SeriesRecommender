class AddSearchRefToSeriesList < ActiveRecord::Migration[6.0]
  def change
    add_reference :series_lists, :search, null: false, foreign_key: true
  end
end
