module Devise::CapybaraTestHelpers
  def log_in(username, password)
    visit "/"
    fill_in "user_email", with: username
    fill_in "user_password", with: password
    click_button("Log in")
  end

  def log_out
    click_link "Logout"
  end
end
