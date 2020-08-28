require './lib/station.rb'

describe 'a station' do
  it 'shows the station zone' do
    station = Station.new("Angel", 1)
    # verify
    expect(station.zone).to eq 1
  end

  it 'shows the station name' do
    station = Station.new("Angel", 1)
    # verify
    expect(station.name).to eq "Angel"
  end
end
