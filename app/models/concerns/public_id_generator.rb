# frozen_string_literal: true
 
module PublicIdGenerator
    extend ActiveSupport::Concern
   
    included do
      class_attribute :public_id_prefix
      self.public_id_prefix = nil
   
      before_create :set_public_id
    end
   
    PUBLIC_ID_ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    PUBLIC_ID_LENGTH = 11 # with 5 characters : 62^5 = 916 132 832 possibilities
    MAX_RETRY = 1000 # Maximum number of retries
   
    class_methods do
      def generate_nanoid(alphabet: PUBLIC_ID_ALPHABET, size: PUBLIC_ID_LENGTH, prefix: nil)
        random_id = Nanoid.generate(size:, alphabet:)
        prefix.present? ? "#{prefix}_#{random_id}" : random_id
      end
    end
   
    def set_public_id
      return if public_id.present?
   
      MAX_RETRY.times do
        self.public_id = generate_public_id
        return unless self.class.exists?(public_id:)
      end
      raise "Failed to generate a unique public id after #{MAX_RETRY} attempts"
    end
   
    def generate_public_id
      self.class.generate_nanoid(prefix: self.class.public_id_prefix)
    end
  end


#  Explication:

#Ligne 7-8 : Définissez l'attribut de classe appelé public_id_prefixoù chaque modèle qui inclut le PublicIdGeneratorpeut spécifier le préfixe en fonction des exigences. Exemple cusde modèle client
#Ligne 10 : Ajoutez des rappels d'enregistrement actifs before_createpour attribuer public_idle champ à l'identifiant aléatoire généré par Nano ID. Cela ne sera donc appelé qu'avant de créer une ressource.
#Ligne 13 : Définissez des constantes sur les caractères qui seront utilisés dans le générateur, le Nano ID prendra cette constante pour générer des identifiants aléatoires.
#Ligne 14 : Définissez la longueur maximale de l’ID aléatoire.
#Ligne 15 : Définissez le nombre maximum que l'application essaie en cas de collision. Dans ce cas, l'application essaiera au maximum 1 000 fois jusqu'à trouver l'identifiant aléatoire unique.
#Ligne 18-21 : Définissez la méthode de classe pour générer un identifiant aléatoire avec Nano ID qui est le code réel de génération d'identifiants aléatoires avec Nano ID.
#Ligne 24-32 : à la ligne 10, nous ajoutons un rappel pour appeler cette méthode. Cette méthode effectue un travail pour vérifier si l'identifiant unique a été utilisé ou non et l'attribuer au public_idchamp.
#Ligne 34-36 : Appelez la generate_nanoidméthode et transmettez la prefixdéfinition dans le modèle.

#Utilisation de PublicIdGenerator 
#creer un concern public_id_generator
#include PublicIdGenerator 
 
#self.public_id_prefix = "Team"  # le cas Model Team

#Exposer public_id #

#resources :customers, param: :public_id #  a la route

#Model
#def to_param 
#  public_id 
#end

#Controller

#def set_customer
#  @customer = Customer.find(params[:id]) # par default
# @customer = Customer.find_by!(public_id: params[:public_id]) 
#end


#le lien : https://maful.web.id/posts/how-i-use-nano-id-in-rails/