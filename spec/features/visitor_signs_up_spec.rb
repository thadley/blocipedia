require 'spec_helper'

feature 'Visitor signs up' do
  before :each do
    visit new_user_registration_path
  end

  scenario 'Successfully' do
    fill_in 'Username', with: 'John'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
  end

  scenario 'with blank username' do
    fill_in 'Username', with: ''
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
  end

  scenario 'with blank email' do
    fill_in 'Username', with: 'John'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content("Email can't be blank")
  end

  scenario 'with blank password' do
    fill_in 'Username', with: 'John'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'
    expect(page).to have_content("Password can't be blank")
  end

end


# Tried refactoring form, but test wouldn't pass.


# Feature: Visitor signs up

# Scenario: Successfully

#   Visitor goes to the new user registration page
#   Submits username, email, password, and confirmation
#   Submits information
#   Sees confirmation email message

# Scenario: with blank username

#   Visitor goes to the new user registration page
#   Submits email, password, and confirmation
#   Submits information
#   Sees confirmation email message

# Scenario: with blank email

#   Visitor goes to the new user registration page
#   Submits username, password, and confirmation
#   Submits information
#   Sees error message

# Scenario: with blank password

#   Visitor goes to the new user registration page
#   Submits username and email
#   Submits information
#   Sees error message
