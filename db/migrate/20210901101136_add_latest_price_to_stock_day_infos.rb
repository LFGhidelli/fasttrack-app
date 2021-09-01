class AddLatestPriceToStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_day_infos, :latest_price, :float
  end
end
