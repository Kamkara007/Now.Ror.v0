class AfterSignupuserController < ApplicationController
  before_action :authenticate_user!
  #before_action :country_codes, only: %i[show update]

  include Wicked::Wizard
   steps :sign_up, :profil
  # Asterisk means variable number of arguments
  steps(*User.form_steps)

  def show 
    @user = current_user
    case step
    when 'sign_up'
      skip_step if @user.persisted?
    when 'profil'
      skip_step unless @user.required_for_step?(step)
    when 'creator'
      skip_step unless @user.required_for_step?(step)
    end
    render_wizard
  end


  def update
    @user = current_user
    
    case step
    when 'profil'
      if @user.update(onboarding_params(step))
        render_wizard @user
      else
        render_wizard @user, status: :unprocessable_entity
      end
    when 'creator'
      if @user.update(onboarding_params(step))
        render_wizard @user
      else
        render_wizard @user, status: :unprocessable_entity
      end
    end

  end

  private
  #def country_codes
    #@country_codes = YAML.load_file(Rails.root.join('config', 'country_codes.yml'))['countries'] || []
  #end

  def onboarding_params(step = 'sign_up')
    permitted_attributes = case step
      when 'profil'
        required_parameters = :user
        %i[full_name user_avatar user_status user_bio user_banner]
      when 'creator'
        required_parameters = :user
        %i[full_name user_avatar user_status user_bio user_banner]
      end
    params.require(required_parameters).permit(:id, permitted_attributes).merge(form_step: step)
  end
end

