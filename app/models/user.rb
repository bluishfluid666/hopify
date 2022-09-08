class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  attr_accessor :remember_token, :avatar_upload_width, :avatar_upload_height;
  before_save :downcase_email
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

    def check_avatar_dimensions
      ::Rails.logger.info "Avatar upload dimensions: #{self.avatar_upload_width}x#{self.avatar_upload_height}"
      errors.add :avatar, "Dimensions of uploaded avatar should be not less than 150x150 pixels." if self.avatar_upload_width < 150 || avatar_upload_height < 150
    end

    def uploading?
      avatar_upload_width.nil? && avatar_upload_height.nil?
    end    
    
end
