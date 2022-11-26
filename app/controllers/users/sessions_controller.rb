class Users::SessionsController < ApplicationController
  before_action :check_user_sign_in

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'guestuserでログインしました。'
  end

  # ユーザーのゲストログインを防ぐ
  def check_user_sign_in
    redirect_to user_path(current_user) if user_signed_in?
  end
end
