class User < ApplicationRecord

    def self.build_from_github(auth_hash)
        user = User.new
        user.uid = auth_hash[:uid]
        user.provider = "github"
        user.username = auth_hash["info"]["name"]
        user.email = auth_hash["info"]["email"]
        # will save user outside of this method
        return user
    end

end