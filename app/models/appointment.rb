class Appointment < ApplicationRecord
    belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
    belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

    has_one_attached :left
    has_one_attached :front
    has_one_attached :right


    def num 
        "APPT0#{id}"
    end
end
