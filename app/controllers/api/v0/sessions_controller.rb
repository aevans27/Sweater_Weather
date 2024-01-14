class Api::V0::SessionsController < ApplicationController
  def login
    existing_user = User.find_by(email: params[:email], password: params[:password])
    if existing_user
        render json: {
          "data": {
            "type": "users",
            "id": existing_user.id,
            "attributes": {
              "email": existing_user.email,
              "api_key": existing_user.api_key
            }
          }
        }, status: 200
    else
      render json: {errors: "Bad Credentials"}, status: 404
    end
  end
end