class RemoveClosingDateFromStockDayInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :stock_day_infos, :closing_date, :date
  end
end
