# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :rememberable, :trackable,
         :validatable

  def ldap_authorized?
    encrypted_password == ''
  end
end
