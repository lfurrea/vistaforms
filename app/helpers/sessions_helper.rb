module SessionsHelper

  def sign_in(user)
    session[:remember_token] = user.id
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def sign_out
    current_user = nil
    session.delete(:remember_token)
  end

  private
  def user_from_remember_token
    if !session[:remember_token].nil?
      User.find(session[:remember_token])
    else
      nil
    end
  end

  def signed_in?
    !current_user.nil?
  end


end
