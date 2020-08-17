require './lib/card.rb'

describe 'Card' do
  it 'has a capacity' do
    # set up
    card = Card.new
    # execute

    # verify
    expect(card.capacity).to eq 90
  end
end
