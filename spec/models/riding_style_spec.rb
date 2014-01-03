require 'spec_helper'

describe RidingStyle do
  it { should have_valid(:name).when('Downhill') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_many(:equipment).dependent(:nullify) }
end
