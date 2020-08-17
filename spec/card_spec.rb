require './lib/card.rb'

describe 'Card' do
  it 'has a capacity' do
    # set up
    card = Card.new
    # execute

    # verify
    expect(card.max_value).to eq 90
  end

  it 'adds money' do
    # set up
    card = Card.new
    money = 10
    # execute
    card.add(money)
    # verify
    expect(card.balance).to eq money
  end

  it 'doesn\'t allow too much money to be added' do
    # set-up
    card = Card.new
    # verify
    expect(card.add(100)).to eq 'You can only top up to £90 maximum'
  end
end
