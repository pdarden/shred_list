module AuthenticationHelper
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Username or Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  def sign_out
    visit root_path
    click_link 'Sign Out'
  end
end
