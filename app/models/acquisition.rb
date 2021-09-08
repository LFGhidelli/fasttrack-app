class Acquisition < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validates :value_bought, numericality: true
  validates :amount_bought, numericality: true
end
