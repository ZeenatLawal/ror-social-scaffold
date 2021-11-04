class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(email: params[:email])
    if user.valid_password? params[:password]
      render json: { token: JsonWebToken.encode(sub: user.id), success: ['User logged in successfully.'] }
    else
      render json: { errors: ['Invalid email or password'] }
    end
  end
end
