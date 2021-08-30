class CreateStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_day_infos do |t|
      t.float :closing_price
      t.date :closing_date
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
