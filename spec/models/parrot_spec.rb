require 'rails_helper'

RSpec.describe Parrot, type: :model do
  before :each do
    @parrot = build(:parrot)
  end

  it 'has valid factory' do
    expect(@parrot).to be_valid
  end

  it 'requires color' do
    @parrot.color = nil
    expect(@parrot).to_not be_valid
  end

  it 'validates sex' do
    @parrot.sex = nil
    expect(@parrot).to_not be_valid
  end

  it 'validates age' do
    @parrot.age = nil
    expect(@parrot).to_not be_valid
    @parrot.age = -1
    expect(@parrot).to_not be_valid
    @parrot.age = 500 # Too much
    expect(@parrot).to_not be_valid
  end

  it 'generates name' do
    @parrot.name = nil
    expect(@parrot).to be_valid
    @parrot.save!
    expect(@parrot.name).to_not be_nil
  end

  before :each, genealogy: true do
    # Mother's parents
    @grandmother = create(:parrot, age: 40, sex: 'female', tribal: true, color_name: 'green')
    @grandfather = create(:parrot, age: 50, sex: 'male',   tribal: true, color_name: 'green')
    @mother = create(:parrot, age: 20, sex: 'female', tribal: true, color_name: 'red', father_id: @grandfather.id, mother_id: @grandmother.id)
    @father = create(:parrot, age: 30, sex: 'male',   tribal: true, color_name: 'red')
    @son = create(:parrot, age: 3,  sex: 'male',   tribal: true, color_name: 'green', father_id: @father.id, mother_id: @mother.id)
    @daughter = create(:parrot, age: 5,  sex: 'female', tribal: true, color_name: 'blue', father_id: @father.id, mother_id: @mother.id)
  end

  it 'has two parents', genealogy: true do
    expect(@daughter.parents.count).to eq 2
    expect(@son.parents).to contain_exactly @mother, @father
  end

  it 'has multiple children', genealogy: true do
    expect(@mother.children.count).to eq 2
    expect(@father.children).to contain_exactly @son, @daughter
  end

  it 'has ancestors', genealogy: true do
    expect(@son.ancestors.count).to eq 4
  end

  it 'has descendants', genealogy: true do
    expect(@grandfather.descendants.count).to eq 3
  end

  it 'requires both mother & father', genealogy: true do
    @parrot.mother_id = @mother.id
    expect(@parrot).to_not be_valid
    @parrot.father_id = @father.id
    expect(@parrot).to be_valid
    @parrot.mother_id = nil
    expect(@parrot).to_not be_valid
  end

  it 'requires present parents', genealogy: true do
    @parrot.mother_id = 42
    @parrot.father_id = 100500
    expect(@parrot).to_not be_valid
  end
end
