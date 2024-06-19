class User < ApplicationRecord
  self.per_page = 1
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:patient, :doctor]
  has_many :patient_appointments, foreign_key: :patient_id, class_name: 'Appointment', dependent: :destroy
  has_many :doctor_appointments, foreign_key: :doctor_id, class_name: 'Appointment', dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def self.search(params)
    user = User.doctor
    if !params[:location].blank?
      km = 50 
      km = params[:distance] unless params[:distance].blank? 
      user = user.near(params[:location], params[:distance], units: :km)
    end
    unless params[:name].blank?
      user = user.where('name LIKE ? ', "%#{params[:name]}%")
    end
    if params[:certificates] == 'true'
     user = user.where(certificates: true)
    else
     user = user.where(certificates: false)
    end
  end

end
