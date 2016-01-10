require 'rails_helper'

RSpec.feature 'AddingNewParrots', js: true, type: :feature do
  before :each do
    create :color_red
    create :color_green
    create :color_blue
  end

  xscenario 'User creates new parrot' do
    count = Parrot.count

    visit root_path
    wait_for_ajax

    click_button 'new-parrot-button'
    expect(find('#new-parrot-modal').visible?).to be_truthy

    choose 'new-parrot-sex-male'
    select 'red', from: 'new-parrot-color'
    fill_in 'new-parrot-age', with: 12
    choose 'new-parrot-tribal-true'

    click_button 'create-new-parrot-button'
    wait_for_ajax
    wait_for_ajax

    expect(Parrot.count).to eq (count + 1) # TODO fix it
    expect(select_value('new-parrot-color')).to eq ''
    expect(find('#new-parrot-sex-male').checked?).to eq false
    expect(find('#new-parrot-sex-female').checked?).to eq false
  end

  xscenario 'User sees errors' do
    visit root_path
    wait_for_ajax

    click_button 'new-parrot-button'

    expect(find('#new-parrot-modal').visible?).to be_truthy
    expect(find('#new-error').visible?).to_not be_truthy # TODO fix it

    click_button 'create-new-parrot-button'
    wait_for_ajax

    expect(find('#new-error').visible?).to_not be_truthy
  end

  xscenario 'User can select parents' do
    create :parrot, age: 12, sex: 'male',   color_name: 'red',   tribal: true,  name: 'Foo'
    create :parrot, age: 16, sex: 'male',   color_name: 'red',   tribal: true,  name: 'Bar'
    create :parrot, age: 15, sex: 'female', color_name: 'red',   tribal: true,  name: 'Liza'
    create :parrot, age: 22, sex: 'male',   color_name: 'green', tribal: true,  name: 'Willy'
    create :parrot, age: 3,  sex: 'female', color_name: 'green', tribal: false, name: 'Katy'
    create :parrot, age: 15, sex: 'male',   color_name: 'red',   tribal: false, name: 'Po'

    visit root_path
    wait_for_ajax

    click_button 'new-parrot-button'

    expect(find('#new-parrot-mother')).to have_content %w(Liza)
    expect(find('#new-parrot-mother')).to_not have_content %w(Foo Bar Willy Katy Po)
    expect(find('#new-parrot-father')).to have_content %w(Foo Bar Willy)
    expect(find('#new-parrot-father')).to_not have_content %w(Liza Katy Po)

    choose "new-parrot-mother-#{ Parrot.find_by_name('Liza').id }"

    expect(find('#new-parrot-father')).to have_content %w(Foo Bar)
    expect(find('#new-parrot-father')).to_not have_content %w(Liza Willy Katy Po)
  end
end
