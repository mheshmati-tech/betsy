require "test_helper"

describe User do
  describe "build_from_github" do
    it "returns user with expected and required parameters" do
      user = users(:grace)
      user_hash = mock_auth_hash(user)
      puts user_hash
      returned_user = User.build_from_github(user_hash)
      expect(returned_user).must_be_instance_of User
      expect(returned_user.uid).must_equal user.uid
      expect(returned_user.provider).must_equal user.provider
      expect(returned_user.name).must_equal user.name
      expect(returned_user.email).must_equal user.email

    end
  end
end
