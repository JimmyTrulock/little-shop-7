require "rails_helper"

RSpec.describe "merchant discount new page" do
  before :each do
    @merchant_1 = create(:merchant)
  end

  #Discounts US 2
  it "is linked from merchant discount index page" do
    visit "/merchants/#{@merchant_1.id}/discounts"

    expect(page).to have_link("Create a New Discount")
    click_on("Create a New Discount")
    expect(current_path).to eq(new_merchant_discount_path(@merchant_1))
  end

  it "contains a form to create a new discount" do
    visit new_merchant_discount_path(@merchant_1)
    expect(page).to have_field(:percentage)
    expect(page).to have_field(:quantity)
    expect(page).to have_button("Add Discount")
    fill_in :percentage, with: 0.17
    fill_in :quantity, with: 6
    click_button("Add Discount")
    expect(current_path).to eq(merchant_discounts_path(@merchant_1))
    expect(page).to have_content("17% off, after 6 of any item purchased")
  end

  it "redierects to show page without a complete form" do
    visit new_merchant_discount_path(@merchant_1)
    fill_in :quantity, with: 6
    click_button("Add Discount")
    expect(current_path).to eq(new_merchant_discount_path(@merchant_1))
  end
end