class RemoveNameFromFollowedStocks < ActiveRecord::Migration[6.0]
  def change
    remove_column :followed_stocks, :name, :string
  end
end
