require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

feature 'creates private wiki' do

    scenario 'Successfully' do
        visit new_user_session_path
        # Refactor for premium user when authorizations are created
        login_as(user, :scope => :user)
        visit new_wiki_path
        expect( page ).to have_content('Sign out')
        fill_in 'Title', with: 'Title'
        fill_in 'Body', with: 'This is the body of the wiki.'
        check('Private')
        click_button 'Save'
        expect( page ).to have_content('Your wiki was created')
        expect( page ).to have_content('This is the body of the wiki.')
    end
end

Warden.test_reset!

# Feature: Premium user creates private wiki

# Scenario: Successfully
#   Premium user signs in
#   User goes to wiki creation page
#   User enter title and body of new wiki, checks private option, submits
#   User sees confirmation message
#   User sees newly saved wiki