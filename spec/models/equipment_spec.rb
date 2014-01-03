require 'spec_helper'

describe Equipment do
  it { should validate_numericality_of(:original_price).only_integer }
  it { should validate_numericality_of(:original_price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:original_price) }

  it { should have_many(:pictures).dependent(:destroy) }

  it { should belong_to(:listing) }

  it { should belong_to(:offer) }

  it { should belong_to(:riding_style) }

  it { should belong_to(:category) }

  it { should belong_to(:brand) }
end
