require 'spec_helper'

feature 'User can make offers on listings', %Q{
  As a user who is trading or want to buy
  I want to send messages
  So I can coordinate how I want to exchange my item(s)
} do
  # ACCEPTANCE CRITERIA
  # * I must write a message.
  # * I can send and receive messages in a form provided by the website.
  # * I must sign in to be able to comment.
  # * I can set it as private between me and the lister.
  # * I can add pictures of equipment I want to trade.

  let(:owner) { FactoryGirl.create(:user, email: 'sendmeanoffer@me.com') }
  let(:user) { FactoryGirl.create(:user) }
  let(:listing) { FactoryGirl.create(:listing, user_id: owner.id, state_id: state.id) }
  let(:state) { FactoryGirl.create(:state) }
  let(:private_offer) { FactoryGirl.create(:offer, :private_message, user_id: user.id, listing_id: listing.id) }
  let(:offer1) { FactoryGirl.create(:offer, user_id: user.id, listing_id: listing.id) }
  let(:offer2) { FactoryGirl.create(:offer, user_id: user.id, listing_id: listing.id, description: 'WOOO', private_message: true) }

  before { sign_in_as(user) }

  scenario 'Unauthenticated user tries to make an offer' do
    sign_out
    listing
    visit root_path
    click_link 'Details'

    click_link 'Make An Offer'
    expect(page).to have_content 'Sign Up'
  end

  scenario 'Authenticated user tries to make a public offer' do
    Capybara.match = :first
    ActionMailer::Base.deliveries = []

    visit listing_path(listing)
    click_link 'Make An Offer'
    current_path.should == listing_path(listing)

    fill_in 'Description', with: offer1.description
    click_button 'Submit'

    current_path.should == listing_path(listing)
    expect(page).to have_content 'Your offer was posted!'
    expect(page).to have_content offer1.description
    expect(page).to have_content user.username
    attach_file 'picture_image', Rails.root.join('spec/file_fixtures/sample_longboard.jpg')
    click_button 'Add Picture'
    expect(Picture.last.image.url).to be_present

    expect(ActionMailer::Base.deliveries.size).to eq(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('Someone made an offer on your listing!')
    expect(last_email).to deliver_to(owner.email)

    expect(page).to have_content 'Make An Offer'
    sign_out

    sign_in_as(owner)
    visit listing_path(listing)

    expect(page).to have_content offer1.description
    click_link 'Reply'
    fill_in 'Description', with: 'Okay'
    click_button 'Submit'

    expect(page).to have_content offer1.description
    expect(page).to have_content 'Okay'

    sign_out

    sign_in_as(user)
    visit listing_path(listing)

    expect(page).to have_content offer1.description
    expect(page).to have_content 'Okay'
    click_on 'Reply'
    fill_in 'Description', with: 'Cool'
    click_button 'Submit'

    expect(page).to have_content offer1.description
    expect(page).to have_content 'Okay'
    expect(page).to have_content 'Cool'

    sign_out

    visit listing_path(listing)
    expect(page).to have_content offer1.description
  end

  scenario 'Authenticated user tries to make a private offer' do
    visit listing_path(listing)
    click_link 'Make An Offer'
    current_path.should == listing_path(listing)
    offer1

    fill_in 'Description', with: offer2.description
    check 'Private message'
    click_button 'Submit'
    offer2.destroy

    current_path.should == listing_path(listing)
    expect(page).to have_content offer2.description
    expect(page).to have_content user.username
    expect(page).to have_content 'Make An Offer'
    expect(page).to have_content 'Your offer was posted!'

    sign_out

    visit listing_path(listing)
    expect(page).to have_css('div.hidden')
  end
end
