require 'spec_helper'

feature "User can sort listings", %Q{
  As a general user
  I want to sort the listings
  So that I can decide narrow down my search
} do
  # ACCEPTANCE CRITERIA
  # * I can see all the postings without having to sign in.
  # * I have the option to sort the postings by location (State), brand, price, type of equipment, and type of posting.

  scenario 'I can sort by location'
  scenario 'I can sort by brand'
  scenario 'I can sort by type of posting'
  scenario 'I can sort by category'
  scenario 'I can sort by price'
end

