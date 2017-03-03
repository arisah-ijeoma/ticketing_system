class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    head 406 and return unless user

    if user.authenticate(params[:password])
      user.regenerate_token
      render json: user, status: :created, meta: default_meta,
             serializer: ActiveModel::Serializer::SessionSerializer
    end
  end

  def destroy
    user = User.find_by(token: params[:token])
    head 404 and return unless user
    user.regenerate_token
    head 204
  end
end
