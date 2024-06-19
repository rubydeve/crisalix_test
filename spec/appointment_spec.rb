require 'rails_helper.rb'
RSpec.feature "Appointments", type: :feature, js: true do
  scenario "User books an appointment" do
    # Create necessary data using FactoryBot or directly in the database
    doctor = User.find_or_create_by(email: "doctor@test.com") do |user|
        user.name = 'test doctor'
        user.address = 'Dubai invesment park 2'
        user.password = 'doctor123'
        user.doctor!
    end
    patient = User.find_or_create_by(email: "patient@test.com") do |user|
        user.name = 'test patient'
        user.address = 'Dubai invesment park 2'
        user.password = 'patient123'
        user.patient!
    end
    visit login_path

    # Fill in the login form with valid credentials
    fill_in 'Email', with: 'patient@test.com'
    fill_in 'Password', with: 'patient123'
    click_button 'Sign in'

    # Simulate a user visiting the appointments page
    visit appointments_path

    # Assert that we're on the appointments page
    expect(page).to have_current_path(appointments_path)
    visit new_appointment_path(doctor: doctor)
    # Fill in appointment details and submit the form

    fill_in "Date", with: "2024-06-20 10:00 AM"
    fill_in "Question", with: "What is the diagnosis?"
    select 'In-Person', from: 'addition'

    click_button "Create Appointment"

    # Assert that the appointment was successfully created
    expect(page).to have_selector('.toast-message', text: 'Appointment successfully created.', wait: 100)

    # Optionally, you can check the database state or verify other UI changes
    expect(Appointment.count).to eq(1)
    appointment = Appointment.first
    expect(appointment.doctor).to eq(doctor)
    expect(appointment.patient).to eq(patient)
    expect(appointment.date).to eq(DateTime.parse("2024-06-20 10:00 AM"))
    expect(appointment.question).to eq("What is the diagnosis?")
    expect(appointment.addition).to be true
  end
end
