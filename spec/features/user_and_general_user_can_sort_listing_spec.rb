require 'spec_helper'

feature "User can sort listings", %Q{
  As a general user
  I want to sort the listings
  So that I can decide narrow down my search
} do
  # ACCEPTANCE CRITERIA
  # * I can see all the postings without having to sign in.
  # * I have the option to sort the postings by location (State), brand, type of equipment, and type of posting.

  scenario 'I can sort by location, brand, type of posting, and category' do
    user = FactoryGirl.create(:user)
    alaska = State.create(name: "Alaska")
    brand = Brand.create(name: 'NO')
    brand1 = Brand.create(name: 'YES')
    category = Category.create(name: 'NO')
    category1 = Category.create(name: 'YES')
    posting1 = Listing.create(title: 'Not me!', user_id: user.id, description: 'BOO', trade: false, asking_price: 20000, asking_items: '', state_id: alaska.id)
    Equipment.create(original_price: 20000, brand_id: brand1.id, category_id: category1.id, listing_id: posting1.id )
    newyork = State.create(name: "New York")
    posting = Listing.create(title: "Find Me!", user_id: user.id, description: 'YAY', trade: true, asking_price: 10000, asking_items: "Your soul", state_id: newyork.id)
    Equipment.create(original_price: 20000, brand_id: brand.id, category_id: category.id, listing_id: posting.id )
    visit root_path
    click_on 'Search'
    select 'Trade', from: 'q_trade_eq'
    select newyork.name, from: 'q_state_id_eq'
    select brand.name, from: 'q_equipment_brand_id_eq'
    select category.name, from: 'q_equipment_category_id_eq'
    click_on 'Find'
    expect(page).to have_content posting.title
    expect(page).to_not have_content posting1.title
  end
end

