require 'spec_helper'

describe State do
  it { should have_valid(:name).when('New York') }
  it { should have_many(:listings).dependent(:nullify) }
end
