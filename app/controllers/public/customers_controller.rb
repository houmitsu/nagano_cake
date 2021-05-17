class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def verification
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path
  end

  def customer_params
    params.require(:end_user).permit(:first_name, :last_name, :email)
  end

end
