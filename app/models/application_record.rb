class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  ############### SCOPES ################
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
end