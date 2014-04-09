require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

wiki = FactoryGirl.create(:wiki)
wiki.save

feature 'edits wiki' do
    scenario 'Successfully' do
        login_as(user, :scope => :user)
        visit wikis_path
        click_link 'Title'
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
