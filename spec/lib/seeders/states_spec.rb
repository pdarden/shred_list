require 'spec_helper'

describe Seeders::States do
  let(:seeder) { Seeders::States }

  it 'seeds states' do
    seeded_state = Seeders::States.states.first
    seeder.seed
    expect(State.where(name: seeded_state)).to be_present
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = State.count
    seeder.seed
    expect(State.count).to eq(count_after_seed)
  end

end
