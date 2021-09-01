class AddPreviousCloseToStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_day_infos, :previous_close, :float
  end
end
