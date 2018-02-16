require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do
    user = create(:user, email: "testerson@testmail.com", password: "testing", zip: 80301)
    role = create(:role)
    user_role = create(:user_role, user: user, role: role)
    store = create(:store)
    item_one = create(:item, store: store)

    visit "/login"

    fill_in "session[email]", with: "testerson@testmail.com"
    fill_in "session[password]", with: "testing"

    click_button("Login")

    visit store_items_path(store.slug)
    click_on "Add to cart"
    click_on "Cart"

    expect(page).to have_content("Calculate Shipping")

    click_on "Calculate Shipping"

    expect(current_path).to eq('/shipping')
  
    click_link "Checkout"


    expect(page).to have_content("Order was successfully placed")
  end
end
