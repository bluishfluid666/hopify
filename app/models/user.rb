class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  attr_accessor :remember_token
  before_save :downcase_email
  validates :avatar, file_size: { less_than: 3.megabytes, message: 'avatar should be less than %{count}' }
  validates :name, presence: true, length: { maximum: 50 }
  # validate :check_avatar_dimensions, if :uploading?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(
    :email,
    presence: true,
    uniqueness: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  )
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end
  def session_token
    if self.remember_digest.nil?
      return remember
    else
      return remember_digest
    end
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?;
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def downcase_email
      email = self.email.downcase
    end    
    
end
