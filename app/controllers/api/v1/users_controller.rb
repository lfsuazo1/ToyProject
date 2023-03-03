class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @users=User.all
    render json: serializer.new(@users,include:["question"]),status: :ok
  end

   def create
     @user = User.new(user_params)
     if @user.save
      render json: serializer.new(@user),status: :created
    else
      render json: {errors: @user.errors},status:422
    end
   end

   def show
    begin
    @user = User.find(params[:id])
    render json: serializer.new(@user,include:['question']),status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found
    end
   end

  def get_top_users
    @users=User.order("questions_count DESC").limit(5)
    render json: serializer.new(@users),status: :ok
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
     render json: {},status: :ok
    else
      render json:{errors: @user.errors},status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotFound
      render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: serializer.new(@user), status: :ok
    else
      render json: { data: @user.errors }, status: :unprocessable_entity
      end
      rescue ActiveRecord::RecordNotFound
        render json: { error:{"status":404,"detail":"Object not found"} }, status: :not_found
  end

  private

  def serializer
    UserSerializer
  end

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

end
