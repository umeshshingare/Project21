class AuthenticationController < ApplicationController
  before_action :authenticate_user, only: [:logout, :me]

  # POST /auth/register
  def register
    @user = User.new(user_params)
    
    if @user.save
      token = JwtService.encode(user_id: @user.id)
      render json: {
        message: 'User created successfully',
        user: UserSerializer.new(@user),
        token: token
      }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /auth/login
  def login
    @user = User.find_by(email: params[:email])
    
    if @user&.authenticate(params[:password])
      token = JwtService.encode(user_id: @user.id)
      render json: {
        message: 'Login successful',
        user: UserSerializer.new(@user),
        token: token
      }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # POST /auth/logout
  def logout
    render json: { message: 'Logout successful' }, status: :ok
  end

  # GET /auth/me
  def me
    render json: {
      user: UserSerializer.new(current_user)
    }, status: :ok
  end

  # POST /auth/forgot_password
  def forgot_password
    @user = User.find_by(email: params[:email])
    
    if @user
      @user.generate_reset_password_token
      # TODO: Send email with reset link
      render json: { message: 'Password reset instructions sent to your email' }, status: :ok
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end

  # POST /auth/reset_password
  def reset_password
    @user = User.find_by(reset_password_token: params[:token])
    
    if @user&.reset_password_token_valid?
      if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        @user.clear_reset_password_token
        render json: { message: 'Password reset successful' }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid or expired token' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end

  def authenticate_user
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  rescue ExceptionHandler::InvalidToken, ExceptionHandler::MissingToken
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end

