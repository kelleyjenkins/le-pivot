require 'rails_helper'

describe AdminAnalyticsPresenter do
  let(:analytics) { AdminAnalyticsPresenter.new}
  before :each do
    user = create(:user)
    store = create(:store)
    @item1 = create(:item, store: store)
    @item2 = create(:item, store: store)
    @item3 = create(:item, store: store)
    order_1 = create(:order, user: user)
    order_2 = create(:order, user: user, status: 3)
    order_3 = create(:order, user: user, status: 0)
    order_4 = create(:order, user: user, status: 2)
    order_5 = create(:order, user: user, status: 3)

    order_item_1 = create(:order_item, store: store, order: order_1, item: @item1,  unit_price: @item1.price)
    order_item_2 = create(:order_item, store: store, order: order_2, item: @item2,  unit_price: @item2.price)
    order_item_3 = create(:order_item, store: store, order: order_3, item: @item3,  unit_price: @item3.price)
    order_item_4 = create(:order_item, store: store, order: order_4, item: @item1,  unit_price: @item1.price)
    order_item_5 = create(:order_item, store: store, order: order_5, item: @item2,  unit_price: @item2.price)

  end

  describe '#total_sales' do
    it 'returns the total sales from an order' do
      expect(analytics.total_sales).to eq 20.0
    end
  end

  describe '#average_quantity_purchased' do
    it 'returns the average quantity purchased for an order item' do
      expect(analytics.average_quantity_purchased).to eq 1
    end
  end

  describe '#completed_orders' do
    it 'returns the count of completed orders for an order' do
      expect(analytics.completed_orders).to eq 2
    end
  end

  describe '#sales_by_item_title' do
    it 'returns total sales by item title' do
      expect(analytics.sales_by_item_title).to eq({"#{@item1.title}"=>2, "#{@item2.title}"=>2, "#{@item3.title}"=>1})
    end
  end

  describe '#status_for_items' do
    it 'returns status for items by name' do
      expect(analytics.status_for_items).to eq({["#{@item1.title}", 0]=>1, ["#{@item2.title}", 3]=>1, ["#{@item3.title}", 2]=>1})
    end
  end

  describe '#orders_per_customer' do
    it 'returns user orders' do
      expect(analytics.orders_per_customer).to eq({"gob23@example.com"=>1, "gob24@example.com"=>1, "gob21@example.com"=>2, "gob22@example.com"=>1})
    end
  end

  describe '#items_ordered_per_customer' do
    it 'returns quanity of items order by customer' do
      expect(analytics.items_ordered_per_customer).to eq({"gob27@example.com"=>1, "gob26@example.com"=>1, "gob25@example.com"=>2, "gob28@example.com"=>1})
    end
  end
end
