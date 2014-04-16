require 'spec_helper'

feature 'Guest views public wiki' do

    before :each do
        wiki = FactoryGirl.create(:wiki)
        wiki.save
    end

    scenario 'Successfully' do
        visit wikis_path
        expect( page ).to have_content('Wikis')
        expect( page ).to have_content('Sign In')
        click_link 'Title'
        expect( page ).to have_content('This is the body of the wiki.')
    end
end

# Feature: Guest views public wiki

# Scenario: Successfully
#   Guest goes to wiki index page
#   Guest selects wiki to view
#   Guest views wiki