class AddMerchantToDiscounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :discounts, :merchant, null: false, foreign_key: true
  end
end
