class Stock < ApplicationRecord
  has_many :stock_day_infos
  has_many :followed_stocks
  has_many :acquisitions
end
