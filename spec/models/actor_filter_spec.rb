require 'rails_helper'

RSpec.describe ActorFilter, type: :model do
  it 'filters Heroku Postgres' do
    event = instance_double(Event, actor: 'heroku-postgresql')
    expect(described_class.new(event).filter?).to be(true)
  end

  it 'filters Heroku Redis' do
    event = instance_double(Event, actor: 'heroku-redis')
    expect(described_class.new(event).filter?).to be(true)
  end

  it 'filters HireFire' do
    event = instance_double(Event, actor: 'someone+hirefire')
    expect(described_class.new(event).filter?).to be(true)
  end
end
