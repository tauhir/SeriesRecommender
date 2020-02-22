class CreateSeriesLists < ActiveRecord::Migration[6.0]
  def change
    create_table :series_lists do |t|
      t.string :api_id
      t.string :name
      t.string :language
      t.t.string :external_series, array: true, default: [] 
      t.timestamps
    end
  end
end
