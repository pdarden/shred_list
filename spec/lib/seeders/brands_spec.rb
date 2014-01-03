require 'spec_helper'

describe Seeders::Brands do
  let(:seeder) { Seeders::Brands }

  it 'seeds brands' do
    seeded_brand = Seeders::Brands.brands.first
    seeder.seed
    expect(Brand.where(name: seeded_brand)).to be_present
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = Brand.count
    seeder.seed
    expect(Brand.count).to eq(count_after_seed)
  end

end
