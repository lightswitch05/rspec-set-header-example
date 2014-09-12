require "rails_helper"

describe Api::V1::PostsController do

  context "index" do
    it "retrieves the posts" do
      retrieve_access_token

      get api_v1_posts_path

      expect(response.body).to include('"posts":[]')
      expect(response.response_code).to eq 200
    end

    it "requires a valid session key" do
      get api_v1_posts_path

      expect(response.body).to include('"error":"unauthenticated"')
      expect(response.response_code).to eq 401
    end
  end

  context "create" do
    it "creates a post" do
      retrieve_access_token
      post = FactoryGirl.build(:post)

      post api_v1_posts_path(
        post: {
          title: post.title,
          content: post.content
        }
      )

      expect(response.body).to include('"id":')
      expect(response.body).to include('"title":"' + post.title + '"')
      expect(response.body).to include('"content":"' + post.content + '"')
      expect(response.response_code).to eq 201
    end

    it "requires a valid session key" do
      post = FactoryGirl.build(:post)
      post api_v1_posts_path(
        post: {
          title: post.title,
          content: post.content
        }
      )

      expect(response.body).to include('"error":"unauthenticated"')
      expect(response.response_code).to eq 401
    end
  end

  context "show" do
    it "retrieves a post" do
      retrieve_access_token
      post = FactoryGirl.create(:post)

      get api_v1_posts_path(post, format: :json)
      expect(response.body).to include("id\":#{post.id}")
      expect(response.body).to include('"title":"' + post.title + '"')
      expect(response.body).to include('"content":"' + post.content + '"')
      expect(response.response_code).to eq 200
    end

    it "requires a valid session key" do
      post = FactoryGirl.create(:post)

      get api_v1_posts_path(post, format: :json)
      expect(response.body).to include("id\":#{post.id}")
      expect(response.body).to include('"title":"' + post.title + '"')
      expect(response.body).to include('"content":"' + post.content + '"')
      expect(response.response_code).to eq 200
    end
  end
end
