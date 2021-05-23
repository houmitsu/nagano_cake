class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end

end
