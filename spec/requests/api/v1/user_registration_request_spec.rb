require 'rails_helper'

describe "User API" do
  describe "happy paths" do
    it "can register a new user" do
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)
      
    end
  end
end
