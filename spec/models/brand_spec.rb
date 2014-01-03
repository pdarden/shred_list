require 'spec_helper'

describe Brand do
  it { should have_valid(:name).when('LongBoardLarry') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_many(:equipment).dependent(:nullify) }
end
