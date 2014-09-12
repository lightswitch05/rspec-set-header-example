# Sessions API for starting or destroying a access_token
class Api::V1::SessionsController < ApiController
  skip_before_action :access_token_required, only: :create

  # Create an AccessToken for use with restricted APIs.
  #
  # ==== Attributes
  #
  # * Required
  #   * +email+ - Manager's email address.
  #     * Case insensitive.
  #   * +password+ - Manager's password.
  #
  # ==== HTTP Status Codes
  # * Success: 201 Created
  # * Invalid or missing attributes: 422 Unprocessable Entity
  #
  # ==== Example
  #
  # ===== Request
  #  POST /api/v1/session
  #
  #  {
  #    "email": "bill_bob@example.com",
  #    "password": "poor_password"
  #  }
  #
  # ===== Response
  #  Status: 201 Created
  #
  #  {
  #    "access_token": {
  #      "id": 3,
  #      "manager_id": 1,
  #      "access_token": "raXLEpF9B-vTjQuSHwLL",
  #      "active": true,
  #      "created_at": "2014-06-12T18:36:17.989-04:00",
  #      "updated_at": "2014-06-12T18:36:17.989-04:00"
  #    }
  # }
  def create
    auth_options
    token = AccessToken.create
    if token.save
      respond_with token, location: nil, status: :created
    else
      respond_with({
        error: "invalid_credentials",
        error_message: "Invalid email or password."
      }, location: nil, status: :unprocessable_entity)
    end
  end

  private
    # Force required params for +create+
    def auth_options
      params.require(:email)
      params.require(:password)
    end
end
