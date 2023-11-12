class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(merchant)
    else
      redirect_to new_merchant_discount_path
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  private

  def discount_params
    params.permit(:percentage, :quantity)
  end
end