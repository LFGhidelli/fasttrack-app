class AddDayChangeToStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_day_infos, :day_change, :float
  end
end
