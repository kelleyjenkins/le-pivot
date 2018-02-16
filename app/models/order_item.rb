class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :store

  def self.sum_quantity
    group(:item_id)
  end

  def self.average_quantity
    average(:quantity).to_f.round(2)
  end

end
