# Post API for listing and adding posts
class Api::V1::PostsController < ApiController

  # Get a list of Posts.
  #
  # ==== HTTP Status Codes
  # * Success: 200 OK
  #
  # ==== Example
  #
  # ===== Request
  #  GET /api/v1/posts
  #
  # ===== Response
  #  Status: 200 OK
  #
  def index
    posts = Post.all
    respond_with posts
  end

  # Create a new Post.
  #
  # ==== Attributes
  #
  # * Required
  #   * +post+ - See Post for its required and optional attributes.
  #
  # ==== HTTP Status Codes
  # * Success: 201 Created
  # * Invalid or missing attributes: 422 Unprocessable Entity
  #
  # ==== Example
  #
  # ===== Request
  #  POST /api/v1/posts
  #  {
  #    "post":{
  #      "title": "This is a test",
  #      "content": "Please ignore"
  #    }
  #  }
  #
  # ===== Response
  #  Status: 201 Created
  #  Location: /api/v1/posts/4
  #
  #  {
  #    "post": {
  #      "id": 4,
  #      "title": "This is a test",
  #      "content": "Please ignore"
  #    }
  #  }
  def create
    post = Post.create(create_post_params)
    respond_with :api, :v1, post
  end

  # Get a specific Post.
  #
  # ==== HTTP Status Codes
  # * Post found: 200 OK
  # * Invalid or unknown ID: 404 Not Found
  #
  # ==== Example
  #
  # ===== Request
  #  GET /api/v1/posts/17
  #
  # ===== Response
  #  Status: 200 OK
  #
  #  {
  #    "post": {
  #      "id": 17,
  #      "title": "Hodor",
  #      "content": "Hodor hodor, hodor hodor hodor. Hodor!"
  #    }
  #  }
  def show
    post = Post.find(params[:id])
    respond_with :api, :v1, post
  end

  private

    # Force required +post+ params for +create+
    def create_post_params
      params.require(:post).permit(:title, :content)
    end
end
