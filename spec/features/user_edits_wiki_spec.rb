require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

feature 'edits wiki' do
    scenario 'Successfully' do
        login_as(user, :scope => :user)
        # creates own wiki to have proper authorization to edit
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: 'Title5'
        fill_in 'Body', with: 'This is the body of the wiki.'
        click_button 'Save'
        visit wikis_path
        click_link 'Title5'
        click_link 'Edit Wiki'
        expect( page ).to have_content('Edit Wiki')
        click_button 'Save'
        expect( page ).to have_content('Your wiki was edited')
    end
end

# Feature: User edits wiki

# Scenario: Successfully
#   User creates wiki and views page
#   User clicks link to edit wiki
#   User edits wiki and save changes
#   User sees confirmation message
#   User sees newly edited wiki
