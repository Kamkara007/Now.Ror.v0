class AfterSignupadminController < ApplicationController
  before_action :authenticate_admin!

  include Wicked::Wizard
  # steps :profile, :avatar, :finish
  # Asterisk means variable number of arguments

  steps(*Admin.form_steps)

  def show
    @admin = current_admin
    case step
    when 'sign_up'
      skip_step if @admin.persisted?
    
    #when 'welcome'
    #  @admin = current_admin
    end

    render_wizard
  end

 

  def update
    @admin = current_admin
    case step
    when 'profil'
      if @admin.update(onboarding_params(step))
        redirect_to "/dashboard" #redirect to dashboard after admin profil complet
      else
        render_wizard @admin, status: :unprocessable_entity
      end
    end
  end

  private

  def onboarding_params(step = 'sign_up')
    permitted_attributes = case step
      when 'profil'
          required_parameters = :admin
          %i[full_name first_name last_name admin_avatar admin_banner admin_bio]
      end
    params.require(required_parameters).permit(:id, permitted_attributes).merge(form_step: step)
  end
end
