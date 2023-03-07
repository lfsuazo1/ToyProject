# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController <  ApplicationApiController
      include Devise::Controllers::SignInOut
      skip_before_action :authenticate_user!

      def create
        if (@user = User.find_by_email(params[:user][:email])) && @user.valid_password?(params[:user][:password])
          sign_in(@user)
          render json: { token: JsonWebToken.encode(sub: @user.id) }
        else
          render json: { errors: ['Invalid email or password'] }
        end
      end

      def destroy
        return unless current_user

        sign_out(current_user)
        render json: { msg: 'See you later!' }
      end
    end
  end
end
