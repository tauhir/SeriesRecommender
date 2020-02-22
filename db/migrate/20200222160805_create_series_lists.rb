class CreateSeriesLists < ActiveRecord::Migration[6.0]
  def change
    create_table :series_lists do |t|
      t.string :api_id,
      t.string :name,language,origin_country
      t.string :language,
      t.string[] :external_series
      t.timestamps
    end
  end
end
