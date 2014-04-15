require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

feature 'creates wiki with collaborators' do

    # Creating 2 collaborators
    before do
        user2 = FactoryGirl.create(:user)
        user2.save
        user3 = FactoryGirl.create(:user)
        user3.save
    end
    
    scenario 'Successfully' do
        visit new_user_session_path
        login_as(user, :scope => :user)
        user.update_attribute(:role, 'premium')
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: 'Title'
        fill_in 'Body', with: 'This is the body of the wiki.'
        page.all(:css, ".collaboratorCheckbox")[1].click
        click_button 'Save'
        expect( page ).to have_content('Your wiki was created')
        expect( page ).to have_content('Collaborator')
    end
end

Warden.test_reset!

# Feature: Premium user creates wiki with collaborators

# Scenario: Successfully
#   Premium user signs in
#   User goes to wiki creation page
#   User enter title and body of new wiki, checks collaborators, submits
#   User sees confirmation message
#   User sees newly saved wiki with collaborators
