class AppointmentsController < ApplicationController
    before_action :authenticate_user!, except: [:new]

    def index 
        # current user patients
        if current_user.doctor?
            @appointments = current_user.doctor_appointments
        else
            @appointments = current_user.patient_appointments
        end
    end

    def new 
        if current_user.blank?
            redirect_to login_url 
        else
            @appointment = Appointment.new
        end
    end

    def create 
        @appointment = Appointment.new(appointment_params)
        @appointment.patient = current_user
        if @appointment.save
          flash[:success] = 'Appointment successfully created.'
          redirect_to appointments_path
        else
          render :new
        end
    end

    private
  
    def appointment_params
      params.require(:appointment).permit(:date, :doctor_id, :question, :left, :front, :right)
    end

end
