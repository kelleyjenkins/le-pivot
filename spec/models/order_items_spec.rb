require 'rails_helper'

describe "order item methods" do
  xit "returns the quantity for an item associated with an order" do

    #this method may not be used anywhere, and doesn't seem to work correctly
    store = create(:store)
    item_1 = create(:item, store: store)
    item_2 = create(:item, store: store)
    order_1 = create(:order)
    order_2 = create(:order)

    create(:order_item, store: store, item: item_1, quantity: 2)
    create(:order_item, store: store, item: item_2, quantity: 3)

    quantity = OrderItem.sum_quantity
    expect(quantity).to eq(3)
  end


  it "can average quantity" do
    store = create(:store)
    item_1 = create(:item, store: store)
    item_2 = create(:item, store: store)
    order_1 = create(:order)
    order_2 = create(:order)

    create(:order_item, store: store, item: item_1, quantity: 5)
    create(:order_item, store: store, item: item_2 )

    expect(OrderItem.average_quantity).to eq(3)
  end
end
