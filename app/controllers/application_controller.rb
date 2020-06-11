class ApplicationController < ActionController::Base
    before_action :find_user

    def find_user
        if session[:user_id]
            @logged_user = User.find_by(id: session[:user_id])
        else
            @logged_user = nil 
        end
    end

end
