# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationApiController
      before_action :authenticate_user!, except: :create
      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      def show
        @user = User.find(params[:id])
        render json: @user, include: ['question'], status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: { "status": 404, "detail": 'Object not found' } }, status: :not_found
      end

      def get_top_users
        @users = User.top_five_users
        render json: @users, status: :ok
      end

      def destroy
        @user = User.find(params[:id])
        if @user.destroy
          render json: {}, status: :ok
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: { "status": 404, "detail": 'Object not found' } }, status: :not_found
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: { data: @user.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: { "status": 404, "detail": 'Object not found' } }, status: :not_found
      end

      private

      def serializer
        UserSerializer
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
