require 'spec_helper'

describe Offer do
  it { should have_valid(:description).when("I'll give you my Sector 9 for your board") }
  it { should_not have_valid(:description).when('', nil) }

  it { should belong_to(:user) }

  it { should belong_to(:listing) }

  it { should have_many(:equipment).dependent(:destroy) }
end
