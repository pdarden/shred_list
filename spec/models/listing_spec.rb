require 'spec_helper'

describe Listing do
  let(:blanks) { ['', nil] }

  it { should have_valid(:title).when('A title') }
  it { should_not have_valid(:title).when(*blanks) }

  it { should have_valid(:description).when('This is a brand new board!') }
  it { should_not have_valid(:description).when(*blanks) }

  it { should have_valid(:asking_items).when(*blanks) }

  it { should validate_numericality_of(:asking_price).only_integer }
  it { should validate_numericality_of(:asking_price).is_greater_than_or_equal_to(0) }

  it { should belong_to(:user) }

  it { should belong_to(:state) }
end
