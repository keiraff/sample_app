ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  fixtures :all

  # Возвращает true, если тестовый пользователь осуществил вход.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Осуществляет вход тестового пользователя
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      session_params = { email:       user.email,
                         password:    password,
                         remember_me: remember_me }
      post login_path, params: { session: session_params }
    else
      session[:user_id] = user.id
    end
  end

  private

  # Возвращает true внутри интеграционных тестов
  def integration_test?
    defined?(follow_redirect!)
  end
end

