require "rails_helper"

describe Api::V1::SessionsController do

  context "create" do
    it "creates a session" do
      post api_v1_session_path(email: 'test@exmaple.com', password: 'poor_password')

      expect(response.body).to match(/"access_token":".{20}"/)
      expect(response.response_code).to eq 201
    end
  end
end
