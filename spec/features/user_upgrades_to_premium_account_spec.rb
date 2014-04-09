require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

user = FactoryGirl.create(:user)
user.save

feature 'upgrades to premium account', js: true do
  scenario 'Successfully' do
    login_as(user, :scope => :user)
    visit new_charge_path
    page.should have_content('Click the button!')
    click_button 'Pay with Card'
    stripe_iframe = all('iframe[name=stripe_checkout_app]').last
    within_frame stripe_iframe do
       fill_in 'Email', with: 'example@example.com'
       fill_in 'Card number', with: '4242424242424242'
       fill_in 'CVC', with: '111'
       fill_in 'MM / YY', with: '12/17'
       click_button 'Pay'
    end
    page.should have_content 'Welcome to your premium account'
  end
end

Warden.test_reset!

# Feature: User upgrades to premium account

# Scenario: Successfully
# User goes to premium account sign up page
# User fills in form with payment information
# User sees success message
