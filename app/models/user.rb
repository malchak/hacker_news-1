class User < ActiveRecord::Base
  has_many :comments
  has_many :posts

  validates :username, :email, :password, :presence => true
  validates :username, :email, :uniqueness => true
  validate :valid_email
  validate :password_length
  validate :username_length

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
  def valid_email
    unless email =~ /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
      errors.add(:email, "WEAKSAUCE, this is not a valid email")
    end
  end

  def username_length
    unless username.length > 3
      errors.add(:username, "Username doesn't have enough characters.")
    end
  end

  def password_length
    unless password.length > 6
      errors.add(:password, "Password doesn't have enough characters.")
    end
  end
  
end
