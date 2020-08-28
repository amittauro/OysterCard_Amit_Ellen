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
    allow(station).to receive(:zone) { 1 }
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
    allow(station).to receive(:zone) { 1 }
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
    allow(station1).to receive(:zone) { 1 }
    station2 = test_double('Kings Cross')
    allow(station2).to receive(:name) { 'Kings Cross' }
    allow(station2).to receive(:zone) { 1 }
    station3 = test_double('Angel')
    allow(station3).to receive(:name) { 'Angel' }
    allow(station3).to receive(:zone) { 1 }
    station4 = test_double('Islington')
    allow(station4).to receive(:name) { 'Islington' }
    allow(station4).to receive(:zone) { 1 }
    # execute
    card.touch_in(station1)
    card.touch_out(station2)
    card.touch_in(station3)
    card.touch_out(station4)
    # verify
    expect(card.journey_history).to eq "Bank to Kings Cross\nAngel to Islington"
  end

  it 'charges a penalty fare if you touch in but fail to touch out' do
    # set up
    card = Card.new
    station1 = test_double('Bank')
    allow(station1).to receive(:name) { 'Bank' }
    # execute
    card.touch_in(station1)
    # verify
    expect(card.touch_in(station1)).to eq "Not touched out, penalty fare deducted."
  end
  
  it 'charges a penalty fare if you touch out but failed to touch in' do
    # set up
    card = Card.new
    station1 = test_double('Bank')
    allow(station1).to receive(:name) { 'Bank' }
    allow(station1).to receive(:zone) { 1 }
    # verify
    expect(card.touch_out(station1)).to eq "Not touched in, penalty fare deducted"
  end

  it 'calculates a fare for the journey' do
    # set up
    card = Card.new
    card.add(10)
    station1 = test_double('Bank')
    allow(station1).to receive(:name) { 'Bank' }
    allow(station1).to receive(:zone) { 2 }
    station2 = test_double('Kings Cross')
    allow(station2).to receive(:name) { 'Kings Cross' }
    allow(station2).to receive(:zone) { 1 }
    # execute
    card.touch_in(station1)
    card.touch_out(station2)
    # verify
    expect(card.balance).to eq 4
  end
end
