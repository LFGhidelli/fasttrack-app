class AddYearlyChangeToStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_day_infos, :yearly_change, :float
  end
end
