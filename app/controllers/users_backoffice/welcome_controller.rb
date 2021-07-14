class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_statistc = UserStatistc.find_or_create_by(user: current_user)
  end
end
