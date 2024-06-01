module ApplicationHelper
# Include it in the helpers (e.g. application_helper.rb)
include Pagy::Frontend


#Onglet Title
def title
    base_title = "Appgram"
    if @title.nil?
    base_title
    else
    "#{@title} • #{base_title}"
    end
  end
  def app_name
    "Appgram"
  end
  def language
    "fr"
  end
  #site description
  def description
    "createur de contenu."
  end
  #Site Keys worlds
  def keywords
  " ..."
  end
  #Theme color
  def theme_color
    "#020408"
  end
  def tileColor
    "#020408"
  end
  # user est-il connecter
  def  user_signed_in?
    if current_user
      return true
    elsif current_admin
      return true
    else
      return false
    end
  end
  def user_default_avatar
    render "home/shared/default_avatar_user"
  end
  def admin_default_avatar
    render "homep/shared/default_avatar_admin"
  end
  
end
