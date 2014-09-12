# Describes the serialization of a AccessToken for the API layer
class AccessTokenSerializer < ActiveModel::Serializer
  attributes :id, :access_token, :active, :created_at, :updated_at
end
