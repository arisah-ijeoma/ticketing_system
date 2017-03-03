class UsersController < ApplicationController
  load_and_authorize_resource class: 'User'

  def index
    users = User.all
    render json: users
  end

  def create
    if admin?
      support_agent_create
    else
      customer_create
    end
  end

  private

  def user_params
    params.permit(:email,
                  :first_name,
                  :last_name,
                  :admin,
                  :password,
                  :type)
  end

  def support_agent_create
    user = SupportAgent.new(user_params)

    if user.save
      render json: user, status: :created, serializer: UserSerializer, root: nil
    else
      render json: { error: 'Error creating user' }, status: :unprocessable_entity
    end
  end

  def customer_create
    user = Customer.new(user_params)

    if user.save
      render json: user, status: :created, serializer: UserSerializer, root: nil
    else
      render json: { error: 'Error creating user' }, status: :unprocessable_entity
    end
  end
end
