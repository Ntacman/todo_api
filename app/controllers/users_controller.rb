class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # Creates a user if an email is provided. Password is optional. If blank, application will generate a random password
  def create
    password = user_params['password']
    password = SecureRandom.hex(10) if user_params['password'].blank?
    
    @user = User.new(email: user_params['email'], password: password)

    if @user.save
      render json: {user: @user}
    else
      render json: @user.errors
    end
  end

  def login
    error = ''
    if user_params['email'].present? && user_params['password'].present?
      user = User.find_by(email: user_params['email'])
      if user.authenticate(user_params['password'])
        session[:user] = user
        render json: user
      else
       error = 'password incorrect'
       render json: error
      end
    else
      error = 'email or password invalid'
      render json: error
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end

end
