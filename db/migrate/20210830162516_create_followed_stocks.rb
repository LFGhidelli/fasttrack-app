class CreateFollowedStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :followed_stocks do |t|
      t.string :name
      t.references :stock, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
