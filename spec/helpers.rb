module Helpers
  def login_admin
    admin = create(:user, admin: true)
    controller.login(admin)
    admin
  end

  def login_user
    user = create(:user)
    controller.login(user)
    user
  end
end
