require './lib/journey.rb'

describe 'A journey' do
  it 'has a start' do
    # set up
    station = test_double('station')
    journey = Journey.new(station)
    # verify
    expect(journey.start).to eq station
  end
end
