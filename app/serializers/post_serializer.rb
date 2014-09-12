# Describes the serialization of a Post for the API layer
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at
end
