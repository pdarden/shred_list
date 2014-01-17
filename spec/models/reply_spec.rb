require 'spec_helper'

describe Reply do
  let(:blanks) { ['', nil] }

  it { should have_valid(:body).when('I like that offer, lets exhange soon!') }
  it { should_not have_valid(:body).when(*blanks) }

  it { should belong_to(:offer) }

  it { should belong_to(:sender).class_name('User') }
end
