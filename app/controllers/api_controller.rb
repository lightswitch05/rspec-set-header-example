# Parent controller for all API controllers. JSON is the only supported format.
class ApiController < ActionController::Base
  before_action :access_token_required
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  respond_to :json

  protected
    # Retrieves the `access_token` from header.
    def access_token
      request.headers['HTTP_ACCESS_TOKEN']
    end

  private

    # Enforces a valid AccessToken.
    #
    # Continues on success.
    # Redirects to new session path on failure with 401 HTTP code.
    def access_token_required
      unless valid_token?
        respond_with({
          error: "unauthenticated",
          error_message: "The user doesn't have valid authentication details."
        }, status: :unauthorized, location: api_v1_session_path)
      end
    end

    # Checks if an AccessToken is valid or not.
    def valid_token?
      AccessToken.authenticate(access_token)
    end
end
