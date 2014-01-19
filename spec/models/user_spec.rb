require 'spec_helper'

describe User do
  let(:blanks) { ['', nil] }

  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(*blanks) }

  it { should have_valid(:last_name).when('Smith', 'Collins') }
  it { should_not have_valid(:last_name).when(*blanks) }

  it { should_not have_valid(:username).when(*blanks) }

  describe 'when username is taken' do
    before do
      @user1 = FactoryGirl.create(:user, username: 'samename')
      @user2 = FactoryGirl.build(:user, username: 'samename')
    end

    it { @user2.should_not be_valid }
  end

  it { should have_many(:offers).dependent(:destroy) }

  it { should have_many(:listings).dependent(:destroy) }

  it { should have_many(:replies).dependent(:destroy) }
end
