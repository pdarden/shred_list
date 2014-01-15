require 'spec_helper'

feature 'Unauthenticated user signs up', %Q{
  As a new user
  I want to create an account
  So I can sell, trade, place bid, or buy longboard equipments
} do
  # ACCEPTANCE CRITERIA
  # * I must specify an email address, username, first name, lastname, password, and a password confirmation.
  # * If I don't specify the required fields, I should receive error message(s).
  # * If I specify all the required fields, I am granted access to the system
  # * If I don't specify all the required information, I can't access the system where I can edit profile, post listings, or buy/bid.
  # * I must specify a valid email.
  # * The password confirmation must match the specified password.

  before :each do
    @user1 = FactoryGirl.build(:user)
  end

  scenario 'fill all required fields' do
    Capybara.match = :first
    visit root_path
    click_link 'Sign Up'

    fill_in 'First Name', with: @user1.first_name
    fill_in 'Last Name', with: @user1.last_name
    fill_in 'Username', with: @user1.username
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    fill_in 'Password Confirmation', with: @user1.password_confirmation

    click_button 'Sign Up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "Sign Out"
    expect(page).to have_content "Edit Profile"
  end

  scenario 'required fields not filled' do
    visit new_user_registration_path

    click_button 'Sign Up'

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Sign Out"
    expect(page).to_not have_content "Edit Profile"
  end

  scenario 'invalid email' do
    Capybara.match = :first
    visit new_user_registration_path

    fill_in 'First Name', with: @user1.first_name
    fill_in 'Last Name', with: @user1.last_name
    fill_in 'Username', with: @user1.username
    fill_in 'Email', with: 'me.com'
    fill_in 'Password', with: @user1.password
    fill_in 'Password Confirmation', with: @user1.password_confirmation

    click_button 'Sign Up'

    expect(page).to have_content "Emailis invalid"
  end

  scenario 'invalid password confirmation' do
    Capybara.match = :first
    visit new_user_registration_path

    fill_in 'First Name', with: @user1.first_name
    fill_in 'Last Name', with: @user1.last_name
    fill_in 'Username', with: @user1.username
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    fill_in 'Password Confirmation', with: 'anotherpassword'

    click_button 'Sign Up'

    expect(page).to have_content "Password Confirmationdoesn't match"
  end

end
