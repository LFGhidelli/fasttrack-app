class CreateAcquisitions < ActiveRecord::Migration[6.0]
  def change
    create_table :acquisitions do |t|
      t.float :value_bought
      t.float :amount_bought
      t.date :date_bought
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
