require "rspec"

require_relative "basketball"

describe Player do
  it "is valid with a firstname, lastname, phonenumber, and hometown" do
    player = Player.new(firstname: 'LeBron',
      lastname: 'James',
      phonenumber: '666-6666',
      hometown: 'Akron')
    expect(player).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Player.new(firstname: nil)).to have(1)
.errors_on(:firstname)  
  end

  it "is invalid without a lastname" do
    expect(Player.new(lastname: nil)).to have(1)
.errors_on(:lastname) 
  end

  it "is invalid without a phone number" do
    expect(Player.new(phonenumber: nil)).to have(1)
.errors_on(:phonenumber) 
  end

  it "is invalid without a hometown" do
    expect(Player.new(hometown: nil)).to have(1)
.errors_on(:hometown) 
  end

  it "is invalid with a duplicate phone number" do
    Player.create(firstname: 'LeBron',
      lastname: 'James',
      phonenumber: '666-6666',
      hometown: 'Akron')
    player = Player.new(firstname: 'Dwyane',
      lastname: 'Wade',
      phonenumber: '666-6666',
      hometown: 'Chicago')
    expect(player).to have(1).errors_on(:phonenumber)
  end

  it "has a #name method which returns the full name of the Player" do
    player = Player.create(firstname: 'Kyrie',
      lastname: 'Irving',
      phonenumber: '222-2222',
      hometown: 'Melbourne')
    expect(player.name).to eq 'Kyrie Irving'
  end

  it "belongs to a team" do
    player = Player.new(firstname: 'LeBron',
      lastname: 'James',
      phonenumber: '666-6666',
      hometown: 'Akron')
    expect(player).to respond_to :team
  end

  it "three Players with correct names should exist in the database" do
    expect(Player.order(:firstname).map_by {|player| player.name }).to eq ["Kobe Bryant", "Michael Jordan", "Scottie Pippen"]
  end

end

describe Sponsor do
  it "is valid with a name, product, and origin" do
    sponsor = Sponsor.new(name: "Lucky Strike",
      product: "tobacco",
      origin: "USA")
    expect(sponsor).to be_valid
  end

  it "is invalid without a name" do
    expect(Sponsor.new(name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid without a product" do
    expect(Sponsor.new(product: nil)).to have(1).errors_on(:product)
  end

  it "is invalid without an origin" do
    expect(Sponsor.new(origin: nil)).to have(1).errors_on(:origin)
  end

  it "is invalid with a duplicate name" do
    Sponsor.create(name: "Lucky Strike",
      product: "tobacco",
      origin: "USA")
    sponsor = Sponsor.new(name: "Lucky Strike",
      product: "bowling balls",
      origin: "New Zealand")
    expect(sponsor).to have(1).errors_on(:name)
  end
end

describe Team do
  it "is valid with a name and city" do
    team = Team.new(name: "Heat",
      city: "Miami")
    expect(team).to be_valid
  end

  it "is invalid without a name" do
    expect(Team.new(name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid without a city" do
    expect(Team.new(city: nil)).to have(1).errors_on(:city)
  end

  it "is invalid with a duplicate name" do
    Team.create(name: "Celtics",
      city: "Boston")
    team = Team.new(name: "Celtics",
      city: "Auckland")
    expect(team).to have(1).errors_on(:name)
  end

  it "has many players" do
    team = Team.new(name: "Pelicans",
      city: "New Orleans")
    expect(team).to respond_to (:players)
  end

  before do
    @bulls = Team.find_by(name: "Bulls")
    @lakers = Team.find_by(name: "Lakers")
  end

  it "two teams, Bulls and Lakers should exist in the database" do
    expect(Team.order(:name).map(&:name)).to eq ["Bulls", "Lakers"]
  end

  it "the Bulls should have 3 sponsors" do
    expect(@bulls.sponsors.count).to eq 3
  end

  it "the Lakers should have 4 sponsors" do
    expect(@lakers.sponsors.count).to eq 4
  end

  it "the Lakers sponsors are all based in USA" do
    expect(@lakers.sponsors.map(&:origin).uniq).to eq ['USA']
  end
end

