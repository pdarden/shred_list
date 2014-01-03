require 'spec_helper'

describe Seeders::RidingStyles do
  let(:seeder) { Seeders::RidingStyles }

  it 'seeds riding styles' do
    seeded_riding_style = Seeders::RidingStyles.riding_styles.first
    seeder.seed
    expect(RidingStyle.where(name: seeded_riding_style)).to be_present
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = RidingStyle.count
    seeder.seed
    expect(RidingStyle.count).to eq(count_after_seed)
  end

end
