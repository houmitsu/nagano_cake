class Public::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @addresses = Address.all
    @ordered = Order.all
  end

  def thanks
  end

  def verification
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      tal = cart_item.item.excluding_tax_price * cart_item.amount
      @total += tal
    end
    if session[:customer]["payment_method"] == "credit"
      @payment_method = "クレジット払い"
    elsif session[:customer]["payment_method"] == "bunk"
      @payment_method = "現金払い"
    end
  end

  def confirmed
    order = Order.new(session[:user])
    order.postage = 500
    order.payment = 1000
    order.status = 1
    order.end_user_id = current_end_user.id
    order.save
    cart_items = current_end_user.cart_items
    cart_items.each do |cart_item|
      ordered_item = OrderedItem.new
      ordered_item.item_id = cart_item.item.id
      ordered_item.production_status = 0
      ordered_item.unit_price = cart_item.item.excluding_tax_price
      ordered_item.quantity = cart_item.amount
      ordered_item.order_id = order.id
      ordered_item.save
    end
    cart_items.destroy_all
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method)
  end

  def cart_item_any?
    if current_customer.cart_items.empty?
      redirect_to customers_path
    end
  end

end
