require 'rails_helper'

describe "As a user" do
  describe "visits /orders" do
    it "can see all past orders" do
      user = create(:registered_user)
      role = create(:role, title: "registered_user")
      user_role = create(:user_role, user: user, role: role)
      item = create(:item, price: 5.00)
      # items_with_quantity = [ {item => 2} ]
      order_1 = create(:order, user: user, status: 1)
      order_2 = create(:order, user: user, status: 1)
      order_3 = create(:order, user: user, status: 1)

      # order_1.add({item => 2})
      # order_2.add({item => 2})
      # order_3.add({item => 2})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit orders_path

      expect(page).to have_css(".order", count: 3)

      within("#order-#{order_1.id}") do
        expect(page).to have_content(order_1.id)
        expect(page).to have_content(order_1.status.capitalize)
        expect(page).to have_content("$1,000.00")
      end
      within("#order-#{order_3.id}") do
        expect(page).to have_content(order_3.id)
        expect(page).to have_content(order_3.status.capitalize)
        expect(page).to have_content("$1,000.00")
      end
    end
  end
end
