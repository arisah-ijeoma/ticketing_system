class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    render json: {'message' => 'You are not unauthorized to access this page'}, status: 403
  end

  before_action :validate_login

  def validate_login
    token = request.headers['Authorization']
    return unless token

    user = SupportAgent.find_by(token: token) || Customer.find_by(token: token)
    return unless user

    user.touch
    @current_user = user
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

  private

  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end

  def admin?
    @current_user.try(:admin)
  end
end
