require 'spec_helper'

feature 'Authenticated user can edit a listing', %Q{
  As a lister
  I want to edit my listing
  So I can provide updated information
} do
  # ACCEPTANCE CRITERIA
  # * I am provided with an over view of the listing information.
  # * I must have an option to edit my listing.
  # * I am provided with fields to edit my listing.
  # * I am provided with listing options (selling or trading).
  # * I can save new changes.

  let(:user) { FactoryGirl.create(:user) }
  let(:listing) { FactoryGirl.create(:listing, user_id: user.id, state_id: state.id) }
  let(:random_listing) { FactoryGirl.create(:listing, title: 'RANDOM',  user_id: 9, state_id: state2.id) }
  let(:brand) { FactoryGirl.create(:brand, name: 'Sector9') }
  let(:equipment) { FactoryGirl.create(:equipment, brand_id: brand.id, equipmentable_type: 'Listing', equipmentable_id: listing.id, category_id: category.id) }
  let(:picture) { FactoryGirl.create(:picture, equipment_id: equipment.id) }
  let(:state) { FactoryGirl.create(:state, id: 1) }
  let(:state2) { FactoryGirl.create(:state, id: 2) }
  let(:category) { FactoryGirl.create(:category, id: 2) }

  before { sign_in_as(user) }
  before { listing }
  before { brand }
  before { equipment }
  before { state }
  before { state2 }

  scenario 'user edit his/her own listing' do
    random_listing
    visit root_path
    expect(page).to have_content 'Find Your Shred'
    expect(page).to have_content listing.title
    expect(page).to have_content listing.description
    expect(page).to have_content random_listing.title
    click_link 'My Listings'
    current_path.should == user_listings_path(user)
    expect(page).to_not have_content random_listing.title
    expect(page).to have_content listing.title
    click_link 'Details'
    click_link 'Edit Listing'
    fill_in 'Title', with: 'New Title'
    click_button 'Update Listing'
    within ('.container') do
      click_link 'My Listings'
    end

    current_path.should == user_listings_path(user)
    expect(page).to have_content 'New Title'
    expect(page).to_not have_content listing.title
    sign_out
  end

  scenario 'unauthenticated user tries to edit a listing' do
    sign_out
    visit root_path
    expect(page).to have_content listing.title
    click_link 'Details'
    expect(page).to_not have_content 'Edit Listing'
  end
end
