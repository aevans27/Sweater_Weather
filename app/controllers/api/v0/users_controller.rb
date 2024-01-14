class Api::V0::UsersController < ApplicationController
  def create
    if params[:email].present? && params[:password].present? && params[:password_confirmation].present?
      if params[:password] == params[:password_confirmation]
        new_key = SecureRandom.hex(10)
        new_user = User.create(email: params[:email], password: params[:password], api_key: new_key)
        render json: {
          "data": {
            "type": "users",
            "id": new_user.id,
            "attributes": {
              "email": new_user.email,
              "api_key": new_user.api_key
            }
          }
        }, status: 201
      else
        render json: {errors: "Passwords don't match"}, status: 404
      end
    else
      render json: {errors: "Empty fields"}, status: 404
    end
  end
end