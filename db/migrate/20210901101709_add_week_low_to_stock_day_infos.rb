class AddWeekLowToStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_day_infos, :week_low, :float
  end
end
