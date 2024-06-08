class Post < ApplicationRecord

  #################### INCLUTIONS ####################
  include PublicIdGenerator
 
  ##################### RELATIONS ####################
  belongs_to :user
  has_rich_text :content
 
 
  #################### VALIDATIONS ####################
  validates :content, presence: { message: "Le contenu est requis." }
  validates :user_id, presence: { message: "vous devez etre connecter." }
  #validates :public_id, presence:{message: "L'identifiant public est requis."}
 
  #################### SCOPES ####################
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
 
 
 end
 