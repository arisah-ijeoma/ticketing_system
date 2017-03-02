class ApplicationController < ActionController::API
  before_action :validate_login

  def validate_login
    token = request.headers["X-Api-Key"]
    return unless token
    user = User.find_by(token: token)
    return unless user
    if 15.minutes.ago < user.updated_at
      user.touch
      @current_user = user
    end
  end

  def validate_user
    head 403 unless @current_user
  end

  def default_meta
    {
        licence: 'CC-0',
        authors: ['Jay'],
        logged_in: (@current_user ? true : false)
    }
  end
end
