USERS = [{username: 'hi',email: 'abc@gmail.com', uid: 12345, provider: 'github'}]


class UsersController < ApplicationController

  def index
    @users = USERS
  end

  def show
    # @user = User.find_by(id: params[:id])
    # render_404 unless @user
  end

end
