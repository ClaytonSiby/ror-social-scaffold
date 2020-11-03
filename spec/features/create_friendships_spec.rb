require 'rails_helper'

RSpec.feature 'CreateFriendships', type: :feature do
  before(:each) { User.create!(name: 'John', email: 'john@gmail.com', password: 'johndoe') }
  scenario 'User creates a new friendship' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Clayton'
    fill_in 'Email', with: 'claytonsiby@gmail.com'
    fill_in 'Password', with: 'clayton'
    fill_in 'Password confirmation', with: 'clayton'
    click_button 'Sign up'
    click_on 'All users'
    click_button 'Invite to Friendship'
    expect(page).to have_text('Friend request sent!')
  end
end
