class UsersController < ApplicationController
  include Authenticatable

  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer, status: :ok
  end

  # GET /users/:id
  def show
    render json: @user, serializer: UserSerializer, status: :ok
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      render json: {
        message: 'User updated successfully',
        user: UserSerializer.new(@user)
      }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role)
  end

  def authorize_user
    unless current_user.admin? || current_user == @user
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end

