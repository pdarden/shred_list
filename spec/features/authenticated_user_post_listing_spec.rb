require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Authenticated user signs in and post a listing', %Q{
  As an authenticated user
  I want to add my equipment
  So the app can post my listings
} do
  # ACCEPTANCE CRITERIA
  # * I must be signed in to post a listing.
  # * If I'm not signed in, I'm not allowed access to add a listing.
  # * I must specify whether I want to sell or trade my equipment OR buy or put a bid, equipment's initial value, State I'm living in, brand, type of equipment, price, and a description of the listing if applicable.
  # * I can post a picture of the equipment.
  # * If I specify the required details, the listing is posted and I receive a friendly confirmation.
  # * If I don't, I'm presented with error messages.
  # * If I successfully created a listing, I am redirected to the listing show page.

  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  scenario 'user signs in and can access create listing page' do
    visit root_path
    click_link 'Sell | Trade'
    current_path.should == new_listing_path
    expect(page).to have_content 'Create New Listing'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'State'
    expect(page).to have_content 'Trade'
    expect(page).to have_content 'Asking Price'
    expect(page).to have_content 'Asking Items'
    Warden.test_reset!
  end

  scenario 'unauthenticated user tries to access create listing page' do
    logout(:user)
    visit root_path
    click_link 'Sell | Trade'
    current_path.should == new_user_registration_path
    Warden.test_reset!
  end

  scenario 'authenticated user creates a listing with all required fields' do
    state = State.create(name: 'Connecticut')
    brand = Brand.create(name: 'Loaded')
    category = Category.create(name: 'Completes')
    riding_style = RidingStyle.create(name: 'Downhill')
    visit new_listing_path
    user_listing = FactoryGirl.build(:listing, user_id: user.id, asking_price: '200.37')

    fill_in 'Title', with: user_listing.title
    fill_in 'Description', with: user_listing.description
    choose('Sell')
    select state.name, from: 'listing_state_id'
    fill_in 'Asking Price', with: user_listing.asking_price

    click_button 'Add Listing'
    expect(page).to have_content user_listing.title

    click_link 'New Equipment'
    fill_in 'Original Price', with: user_listing.asking_price
    select brand.name, from: 'equipment_brand_id'
    select category.name, from: 'equipment_category_id'
    select riding_style.name, from: 'equipment_riding_style_id'
    click_button 'Create Equipment'

    attach_file 'picture_image', Rails.root.join('spec/file_fixtures/sample_longboard.jpg')
    click_button 'Add Picture'
    expect(Picture.last.image.url).to be_present

    click_link 'Back to listing'

    expect(page).to have_content user_listing.title
    save_and_open_page
    expect(page).to have_content '$200.37'
    expect(page).to have_content 'New Equipment'



    Warden.test_reset!
  end

  scenario 'authenticated user creates a listing without all required fields' do
    visit new_listing_path
    click_button 'Add Listing'

    expect(page).to have_content "can't be blank"
  end

end
