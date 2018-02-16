class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items
  has_many :order_items
  has_many :stores, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def total_price
    items.sum(:price)
  end

  def date
    created_at.strftime('%b. %d, %Y')
  end

  def self.total_orders
    count
  end

  def self.count_by_status
    group(:status).count
  end

  def self.filter_by_status(status)
    where(status: status)
  end

  def self.count_of_completed_orders
    where(status: :completed).count
  end

  def self.shop_total_gross
		# where(status: :completed).joins(:items).sum(:price)
    where(status: "completed").sum("orders.total")
  end

  def grand_total
    total + shipping
  end


  def order_total
    price_and_quantity.map do |price, quantity|
      price * quantity
    end.sum
  end


  def price_and_quantity
    hash = {}
    order_items.each do |item|
      hash[item.unit_price] = item.quantity
    end
    hash
  end


  def create_order_with_associations(user, cart, rate, total)

    order = Order.create!(status: "ordered", user_id: user.id, total: total, shipping: rate)
    cart_items = cart.contents.map do |item_id, quantity|
      CartItem.new(item_id, quantity)
    end

    cart_items.each do |cart_item|
      OrderItem.create(item_id: cart_item.item.id, order_id: order.id, quantity: cart_item.quantity, unit_price: cart_item.item.price, store_id: cart_item.store.id)
    end

  end

  def items_with_quantity(cart_hash)
    cart_hash.contents.inject({}) do |hash, (item_id, quantity)|
      hash[Item.find(item_id)] = quantity
      hash
    end
  end


end
