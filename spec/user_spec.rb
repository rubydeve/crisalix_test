
require 'rails_helper'

RSpec.feature "User Management", type: :feature, js: true do
    scenario "User signs up and logs as patient" do
        visit register_path
        fill_in "Name", with: "test patient"
        fill_in "Address", with: "Dubai invesment park 2"
        fill_in "Email", with: "patient@test.com"
        fill_in "Password", with: "patient123"
        choose 'Patient'
        click_button "Sign up"
        # Fill in the login form with valid credentials
        visit login_path
        fill_in "Email", with: "patient@test.com"
        fill_in "Password", with: "patient123"
        click_button 'Sign in'
        expect(page).to have_current_path(dashboard_path)
    end
    scenario "User signs up and logs as doctor" do
        visit register_path
        fill_in "Name", with: "test doctor"
        fill_in "Address", with: "Dubai invesment park 2"
        fill_in "Email", with: "doctor@test.com"
        fill_in "Password", with: "doctor123"
        choose 'Doctor'
        click_button "Sign up"

        # Fill in the login form with valid credentials
        visit login_path
        fill_in "Email", with: "doctor@test.com"
        fill_in "Password", with: "doctor123"
        click_button 'Sign in'
        expect(page).to have_current_path(dashboard_path)

        expect(page).to have_current_path(dashboard_path)
    end
end
