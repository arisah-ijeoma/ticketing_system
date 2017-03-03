module AuthHelper
  def login(user)
    request.env['HTTP_AUTHORIZATION'] = user.token
  end
end
