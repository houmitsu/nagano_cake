class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @addresses = Address.all
    @ordered = Order.all
  end

  def thanks
  end

  def verification
    if params[:address_select] == "0"
      @order = Order.new
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:address_select] == "1"
      @order = Order.new
      @order_address = Address.find(params[:address_id])
      @order.address = @order_address.address
      @order.postal_code = @order_address.postal_code
      @order.name = @order_address.name

    elsif params[:address_select] == "2"
      @order = Order.new
      @order.address = params[:address]
      @order.postal_code = params[:postal_code]
      @order.name = params[:name]
    end

    @order.shipping_cost = 500

    @cart_items = current_customer.cart_items
    @total = 0
    #@cart_items.each do |cart_item|
    #tal = cart_item.item.excluding_tax_price * cart_item.amount
    #@total += tal
    #end
    #if session[:customer]["payment_method"] == "credit"

    if params[:payment_method] == "0"
      @order.payment_method = 0
    #elsif session[:customer]["payment_method"] == "bunk"
    elsif params[:payment_method] == "1"
      @order.payment_method = 1
    end
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item.id
      order_detail.making_status = 0
      order_detail.price = cart_item.item.excluding_tax_price
      order_detail.amount = cart_item.amount
      order_detail.order_id = order.id
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :total_payment, :shipping_cost)
  end

  def cart_item_any?
    if current_customer.cart_items.empty?
      redirect_to customers_path
    end
  end

end
