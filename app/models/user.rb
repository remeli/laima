#encoding: UTF-8

class User < ActiveRecord::Base
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }
   
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def button_value
    if new_record?
      "Регистрация"
    else
      "Обновить"
    end
  end
  
end
