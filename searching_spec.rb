require 'rails_helper'

feature 'Searching' do

  before (:each) do 
    create :escort
    I18n.locale = :en
  end

  scenario 'Successfully search with correct first_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'Successfully search with correct last_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[last_name]', with: 'paige'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and incorrect last_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'xyz'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with incorrect first_name and correct last_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'xyzs'
    fill_in 'search[last_name]', with: 'paige'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and incorrect city' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Melbourne', from: "search[city]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and
            correct city and incorrect age' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Sydney', from: "search[city]"
    fill_in 'Age', with: '58'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and correct
            city and correct age and incorrect-Hair_color' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Sydney', from: "search[city]"
    fill_in 'Age', with: '28'
    select 'Black', from: "search[hair_colour]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and
            correct city and correct age and
            correct-Hair_color and incorrect-Body_type' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Sydney', from: "search[city]"
    fill_in 'Age', with: '28'
    select 'Blonde', from: "search[hair_colour]"
    select 'Petite', from: "search[body_type]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and
            correct city and correct age and
            correct-Hair_color and correct-Body_type and incorrect body type' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Sydney', from: "search[city]"
    fill_in 'Age', with: '28'
    select 'Blonde', from: "search[hair_colour]"
    select 'Slim', from: "search[body_type]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No record with correct first_name and correct last_name and
            correct city and correct age and
            correct-Hair_color and correct-Body_type
            and incorrect-cup_size' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'emma'
    fill_in 'search[last_name]', with: 'paige'
    select 'Sydney', from: "search[city]"
    fill_in 'Age', with: '28'
    select 'Blonde', from: "search[hair_colour]"
    select 'Athletic', from: "search[body_type]"
    select 'F', from: "search[cup_size]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'Successfully search with city' do
    visit root_path
    click_on('Search')
    select 'Sydney', from: "search[city]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'Successfully search with age' do
    visit root_path
    click_on('Search')
    fill_in 'Age', with: '28'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'Successfully search with Hair_color' do
    visit root_path
    click_on('Search')
    select 'Blonde', from: "search[hair_colour]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'Successfully search with body_type' do
    visit root_path
    click_on('Search')
    select 'Athletic', from: "search[body_type]"
    click_button 'Search'
    expect(page.current_path).to eq (root_path)
    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'Successfully search with cup_size' do
    visit root_path
    click_on('Search')
    select 'B', from: "search[cup_size]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_selector('.card', visible: true)
    expect(page).not_to have_content('No escort found!')
  end

  scenario 'No result with incorrect first_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'xyz'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content("No escort found!")
  end

  scenario 'No result with incorrect last_name' do
    visit root_path
    click_on('Search')
    fill_in 'search[first_name]', with: 'tuv'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content("No escort found!")
  end

  scenario 'No result with incorrect city' do
    visit root_path
    click_on('Search')
    select 'Melbourne', from: "search[city]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No result with incorrect age' do
    visit root_path
    click_on('Search')
    fill_in 'Age', with: '80'

    click_button 'Search'
    expect(page.current_path).to eq (root_path)
    expect(page).to have_content('No escort found!')
  end

  scenario 'No result with incorrect Hair color' do
    visit root_path
    click_on('Search')
    select 'Black', from: "search[hair_colour]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)
    expect(page).to have_content('No escort found!')
  end

  scenario 'No result with incorrect body type' do
    visit root_path
    click_on('Search')
    select 'voluptuous', from: "search[body_type]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

  scenario 'No result with incorrect cup size' do
    visit root_path
    click_on('Search')
    select 'D', from: "search[cup_size]"

    click_button 'Search'
    expect(page.current_path).to eq (root_path)

    expect(page).to have_content('No escort found!')
  end

end
