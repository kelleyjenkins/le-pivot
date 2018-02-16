class AddStripeIdAndTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_token, :string
  end
end
