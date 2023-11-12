require "rails_helper"

RSpec.describe "merchant dashboard index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @invoice_1 = create(:invoice)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_5)
    @invoice_6 = create(:invoice, customer: @customer_6)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_5 = create(:item, merchant: @merchant_1)
    @item_6 = create(:item, merchant: @merchant_1)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, status: 2)
    @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
    @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
    @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
    @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
    @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
  end

  # US 1
  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end
  
  describe "Merchant Dashboard Links" do
    # US 2
    it "shows links to merchant items index and merchant invoices index" do
      visit merchant_dashboard_path(@merchant_1)
      
      expect(page).to have_content("Items")
      expect(page).to have_content("Invoices")

      click_link("Items")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      
      visit merchant_dashboard_path(@merchant_1)

      click_link("Invoices")

      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    end
  end

  # US 3
  describe "merchant dashboard top customers" do
    it "shows a list of the top 5 customers and a count of their successful transactions" do
      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content("1. #{@customer_1.first_name} #{@customer_1.last_name} - 5 purchases")
      expect(page).to have_content("2. #{@customer_2.first_name} #{@customer_2.last_name} - 4 purchases")
      expect(page).to have_content("3. #{@customer_3.first_name} #{@customer_3.last_name} - 3 purchases")
      expect(page).to have_content("4. #{@customer_4.first_name} #{@customer_4.last_name} - 2 purchases")
      expect(page).to have_content("5. #{@customer_5.first_name} #{@customer_5.last_name} - 1 purchases")
      expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
      expect(page).to_not have_content(@customer_6.first_name)
    end
  end

  #US 4
  describe "Merchant Dashboard Items Ready to Ship" do
    it "a section called Items Ready to Ship that shows items ordered but not shipped" do
      visit merchant_dashboard_path(@merchant_1)
      
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
    end

    it "has the associated invoice number and a link to invoice page" do
      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_5.id)
      expect(page).to_not have_content(@invoice_6.id)

      click_link("#{@invoice_1.id}")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    end
  end

  #US 5
  describe "Merchant Dashboard Invoices sorted by least recent" do
    it "shows date invoice was created and orders items oldest to newest" do
      visit merchant_dashboard_path(@merchant_1)
      expected = @item_1.created_format

      expect(@item_5.name).to appear_before(@item_4.name)
      expect(@item_4.name).to appear_before(@item_3.name)
      expect(@item_3.name).to appear_before(@item_2.name)
      expect(@item_2.name).to appear_before(@item_1.name)

      expect(page).to have_content(expected)
    end
  end
end