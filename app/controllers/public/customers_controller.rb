class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    puts @customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_path
  end

  def verification
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end

end
