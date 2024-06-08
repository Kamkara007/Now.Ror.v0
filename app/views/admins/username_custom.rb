#create concern to build fullname, first_name, last_name

#frozen_string_literal: true

module UsernameCustom
    extend ActiveSupport::Concern

    included do
      before_validation :set_full_name
      before_validation :first_name
      before_validation :last_name
    end
    
    def set_full_name
      full_name = full_name.downcase.capitalize if full_name.present?
    end

    def first_name
      self.first_name = full_name.split(' ').first.capitalize if full_name.present?
    end

    def last_name
      self.last_name = full_name.split(' ').last.capitalize if full_name.present?
    end

  end