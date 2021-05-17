class Admin::OrdersController < ApplicationController
  def show
    @order = order.find(params[:id])
    @ordered_item = @order.ordered_items
    @total = 0
    @ordered_item.each do |ordered_item|
    tol = ordered_item.item.non_taxed_price * ordered_item.quantity
    @total += tol
    end
  end

  def update
    @order = order.find(params[:id])
    if params[:order][:status] == "b"
      order.ordered_items.each do |ordered_item|
        ordered_item.production_status = "b"
        ordered_item.update(production_status: ordered_item.production_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path(order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
