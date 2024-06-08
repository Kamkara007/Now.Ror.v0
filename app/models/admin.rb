class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :lockable, :timeoutable, :trackable

  ################## INCLUTIONS  ########################## 
  include PublicIdGenerator
  include UsernameCustom

  has_one_attached :admin_avatar
  has_one_attached :admin_banner

  #Class level accessor
  cattr_accessor :form_steps do
    %w[sign_up profil]
  end

  # Instance level accessor
  attr_accessor :form_step

  # Set the default form step
  def form_step
    @form_step ||= 'sign_up'
  end
    
  # Check if fields are required based on the current step
  def required_for_step?(step)
    form_step.nil? || self.form_steps.index(step.to_s) <= self.form_steps.index(form_step.to_s)
  end
   

  # Set the default form step
  def form_step
    @form_step ||= 'sign_up'
  end

  # Step validation for sign-up
  with_options if: -> { required_for_step?('sign_up') } do |step|
    step.validates :email, presence: { message: "L'e-mail est requis." }
  end


  ########## AFTER SIGN UP  ##############
    
  # Step validation for profil
  with_options if: -> { required_for_step?('profil') } do |step|
    step.validates :full_name, presence: { message: "Le nom complet est requis." }
    step.validates :first_name, presence: { message: "Le prénom est requis." }
    step.validates :last_name, presence: { message: "Le nom de famille est requis." }
  end
end