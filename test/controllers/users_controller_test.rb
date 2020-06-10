require "test_helper"

describe UsersController do

  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do

      start_count = User.count

      user = users(:grace)

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      get auth_callback_path(:github)

      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      session[:user_id].must_equal user.id

      # Should *not* have created a new user
      User.count.must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do
      start_count = User.count

      user = User.new(uid: 123456, provider: 'github')

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      get auth_callback_path(:github)

      must_redirect_to root_path


      session[:user_id].must_equal User.last.id


      User.count.must_equal (start_count + 1)

    end

    it "redirects to the login route if given invalid user data" do
    end
  end
  
end
