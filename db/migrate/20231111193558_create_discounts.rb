class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.float :percentage
      t.integer :quantity
      t.timestamps
    end
  end
end
