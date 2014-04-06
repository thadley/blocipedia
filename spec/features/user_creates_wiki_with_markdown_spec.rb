require 'spec_helper'
require 'redcarpet'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

feature 'creates wiki with Markdown syntax' do

    before :each do
        logout(:user)
        visit new_user_session_path
    end

    scenario 'Successfully' do
        login_as(user, :scope => :user)
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: 'Title'
        fill_in 'Body', with: 'This is the body of the wiki. This *is* **Markdown**.'
        click_button 'Save'
        expect( page ).to have_content('Your wiki was created')
        expect( page ).to have_content('This is the body of the wiki. This is Markdown.')
    end

    scenario 'with missing title' do
        login_as(user, :scope => :user)
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: ''
        fill_in 'Body', with: 'This is the body of the wiki. This *is* **Markdown**.'
        click_button 'Save'
        expect( page ).to have_content('There was an error creating your wiki')
        expect( page ).to have_content('New Wiki')
    end

    scenario 'with missing body' do
        login_as(user, :scope => :user)
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: 'Title'
        fill_in 'Body', with: ''
        click_button 'Save'
        expect( page ).to have_content('There was an error creating your wiki')
        expect( page ).to have_content('New Wiki')
    end

    scenario 'without being signed in' do
        visit new_wiki_path
        expect( page ).to have_content('not allowed to')
        expect( page ).to have_content('Sign In')
    end
end

Warden.test_reset!

# Feature: User creates wiki with Markdown syntax

# Scenario: Successfully
#   User goes to the wiki creation page
#   User submits title and body of new wiki
#   User sees confirmation message
#   User sees newly saved wiki with Markdown syntax

# Scenario: with missing title
#   User goes to the wiki creation page
#   User submits body of new wiki
#   User sees error message and is redirected to wiki creation page

# Scenario: with missing body
#   User goes to the wiki creation page
#   User submits title of new wiki
#   User sees error message and is redirected to wiki creation page

# Scenario: without being signed in
#   User goes to the wiki creation page
#   User sees error message and is redirected to home page
