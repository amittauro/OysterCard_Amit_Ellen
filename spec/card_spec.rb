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

  it 'touches in to start a journey' do
    # set up
    card = Card.new
    station = test_double('Kings Cross')
    allow(station).to receive(:name) { 'Kings Cross' }
    #
    # verify
    expect(card.touch_in(station)).to eq 'Kings Cross'
  end

  it 'deducts the fare' do
    # set up
    card = Card.new
    card.add(10)
    # execute
    card.deduct
    # verify
    expect(card.balance).to eq 7
  end

  it 'touches out' do
    # set up
    card = Card.new
    # execute
    station = test_double('Bank')
    allow(station).to receive(:name) { 'Bank' }
    card.touch_in(station)
    # verify
    expect(card.touch_out(station)).to eq 'Bank'
  end

  it 'checks for minimum card amount' do
    # set up
    card = Card.new
    card.add(3)
    # verify
    expect(card.min_amount).to eq true
  end

  it 'deducts when touching out' do
    # set up
    card = Card.new
    card.add(10)
    station = test_double('Bank')
    allow(station).to receive(:name) { 'Bank' }
    # execute
    card.touch_in(station)
    card.touch_out(station)
    # verify
    expect(card.balance).to eq 7
  end

  it 'gives the touch in location' do
    # set up
    card = Card.new
    card.add(10)
    station = test_double('Bank')
    allow(station).to receive(:name) { 'Bank' }
    # execute
    card.touch_in(station)
    # verify
    expect(card.touched_in_at).to eq 'Bank'
  end

  it 'lists card journeys' do
    # set up
    card = Card.new
    card.add(10)
    station1 = test_double('Bank')
    allow(station1).to receive(:name) { 'Bank' }
    station2 = test_double('Kings Cross')
    allow(station2).to receive(:name) { 'Kings Cross' }
    station3 = test_double('Angel')
    allow(station3).to receive(:name) { 'Angel' }
    station4 = test_double('Islington')
    allow(station4).to receive(:name) { 'Islington' }
    # execute
    card.touch_in(station1)
    card.touch_out(station2)
    card.touch_in(station3)
    card.touch_out(station4)
    # verify
    expect(card.journey_history).to eq "Bank to Kings Cross\nAngel to Islington"
  end


end
