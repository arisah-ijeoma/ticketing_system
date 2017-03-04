class CustomersController < ApplicationController
  load_and_authorize_resource class: 'Customer'

  def index
    customers = Customer.all
    render json: customers
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: customer, status: :created, serializer: CustomerSerializer, root: nil
    else
      render json: { error: 'Error' }, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :first_name, :last_name, :password)
  end
end
