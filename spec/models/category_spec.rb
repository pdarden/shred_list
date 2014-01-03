require 'spec_helper'

describe Category do
  it { should have_valid(:name).when('Freestyle') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_many(:equipment).dependent(:nullify) }
end
