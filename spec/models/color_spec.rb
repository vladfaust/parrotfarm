require 'rails_helper'

RSpec.describe Color, type: :model do
  before :each do
    @color = build(:color_red)
  end

  it 'has valid factory' do
    expect(@color).to be_valid
  end

  it 'needs a name' do
    @color.name = nil
    expect(@color).to_not be_valid
  end

  it 'has unique name' do
    @color.save
    another_color = Color.new(name: 'red', hex_value: '#anotherhex')
    expect(another_color).to_not be_valid
  end

  it 'needs a hex value' do
    @color.hex_value = nil
    expect(@color).to_not be_valid
  end
end
