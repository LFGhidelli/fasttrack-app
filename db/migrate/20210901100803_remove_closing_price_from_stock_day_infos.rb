class RemoveClosingPriceFromStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :stock_day_infos, :closing_price, :float
  end
end
