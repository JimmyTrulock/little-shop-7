require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before :each do
    @customer = create(:customer)
    @invoice1 = create(:invoice, customer: @customer)
    
    # Create first item and associated invoice item
    @item1 = create(:item) 
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    
    # Create second item and associated invoice item
    @item2 = create(:item) 
    @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @item2)

    # Create a transaction for the invoice
    create(:transaction, invoice: @invoice1) 
  end

  # US 33
  it "lists all of the invoice details on the show page" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("ID: ##{@invoice1.id}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
    expect(page).to have_content("Created Date: #{@invoice1.date_format}")
  end

  # US 34
  it "displays all invoice items and attributes" do
    visit admin_invoice_path(@invoice1.id)

    @invoice1.invoice_items.each do |invoice_item|
      within("#invoice-item-#{invoice_item.id}") do
        expect(page).to have_content("Item: #{invoice_item.item.name}")
        expect(page).to have_content("Quantity Ordered: #{invoice_item.quantity}")
        expect(page).to have_content("Sold Price: #{invoice_item.unit_price}")
        expect(page).to have_content("Invoice Item Status: #{invoice_item.status}")
      end
    end
  end 
end 