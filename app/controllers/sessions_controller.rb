class SessionsController < ApplicationController

  def create
    user = SupportAgent.find_by(email: params[:email]) || Customer.find_by(email: params[:email])
    head 406 and return unless user

    if user.authenticate(params[:password])
      user.regenerate_token

      if user.is_a?(SupportAgent)
        render json: user, status: :created, meta: default_meta,
               serializer: SupportAgentSessionSerializer
      else
        render json: user, status: :created, meta: default_meta,
               serializer: CustomerSessionSerializer
      end

    else
      render json: {message: 'Invalid credentials'}, status: 404
    end
  end

  def destroy
    user = @current_user
    head 404 and return unless user
    user.regenerate_token
    head 204
  end
end
