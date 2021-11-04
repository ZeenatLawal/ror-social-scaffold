class Api::V1::RegistrationController < ApiController
  skip_before_action :authenticate_user!
  def create
    @user = User.create(name: params[:name], email: params[:email],
                        password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      render json: { token: JsonWebToken.encode(sub: @user.id), success: ['User added successfully.'] }
    else
      render json: { errors: ['Registration failed'] }
    end
  end
end
