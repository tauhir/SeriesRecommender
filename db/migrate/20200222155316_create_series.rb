class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series do |t|
      t.string :api_id,
      t.string :name,language,origin_country

      t.timestamps
    end
  end
end
