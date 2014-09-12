# AccessToken is a temporary and unique token used for API access.
#
# ==== Attributes
#
# * Required
#   * +access_token+ - The actual token. Must be unique.
class AccessToken < ActiveRecord::Base
  before_validation :generate_token, on: :create

  validates :access_token, presence: true
  validates_uniqueness_of :access_token

  # Authenticates an AccessToken.
  #
  # Returns the AccessToken if it is a valid token, else returns +nil+.
  def self.authenticate(access_token)
    return exists?(access_token: access_token, active: true)
  end

  private

    # Generates a unique and URL safe token for use with the API
    def generate_token
      self.access_token ||= loop do
        random_token = SecureRandom.urlsafe_base64(15).tr('lIO0', 'sxyz')
        break random_token unless self.class.exists?(access_token: random_token)
      end
    end

    # Scope to only fetch active AccessTokens
    def self.active_only
      where(active: true)
    end
end
