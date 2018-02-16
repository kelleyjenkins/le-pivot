require 'rails_helper'

feature "Admin can view individual order pages" do
  scenario "when I visit an valid order page" do

    user = create(:user, first_name: "Gob", last_name: "Bluth")
    store = create(:store)
    admin = create(:store_admin, store: store)
    role = Role.create(title: "store_admin")
    create(:user_role, user: admin, role: role)
    item_1 = create(:item, price: 11.00)
    item_2 = create(:item, price: 10.00)
    items_with_quantity_for_order = [ {item_1 => 1}, {item_2 => 2} ]
    order = create(:order_with_items, items_with_quantity: items_with_quantity_for_order, shipping: 5.95, total: 31)
    expected_total = "$36.95"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit order_path(order)


    expect(page).to have_content(order.date)
    expect(page).to have_content("Gob Bluth")
    expect(page).to have_content(user.address)

    expect(page).to have_link(item_1.title)
    expect(page).to have_content("$11.00")
    expect(page).to have_link(item_2.title)
    expect(page).to have_content("$10.00")
    expect(page).to have_content(expected_total)


  end
end
