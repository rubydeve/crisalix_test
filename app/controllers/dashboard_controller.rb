class DashboardController < ApplicationController

    def index 
        if current_user.doctor?
            @appointments = current_user.doctor_appointments.last(5)
        else
            @appointments = current_user.patient_appointments.last(5)
        end
    end

    def directory
        if params[:search].blank?
            @doctors = User.doctor.paginate(page: params[:page]).order(id: :desc)
        else
            @doctors = User.search(params[:search]).paginate(page: params[:page])
        end 
    end

end
