require 'spec_helper'

describe Picture do
  it { should validate_presence_of(:image) }

  it { should belong_to(:equipment) }
end
