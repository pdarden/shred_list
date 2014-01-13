require 'spec_helper'

feature "viewer can view a specific user's listings", %Q{
  As a user
  I want to browse someone else's profile
  So I can see if they have other listings
} do
  # ACCEPTANCE CRITERIA
  # * I want to see a list of listings that a specific person posted.
  # * I can click on a list of listings and it will redirecting me to the post.

  scenario 'user view a profile' do
    user = FactoryGirl.create(:user)
    state = State.create(name: "New York")
    listing = FactoryGirl.create(:listing, user_id: user.id, state_id: state.id)
    visit root_path
    click_link 'Details'

    click_link user.username

    expect(page).to have_content listing.title
    click_link listing.title
    expect(page).to have_content user.username
    expect(page).to have_content listing.title
    expect(page).to have_content listing.state.name
  end
end

