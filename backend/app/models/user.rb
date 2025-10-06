class User < ApplicationRecord
  has_secure_password

  # Associations
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # Enums
  enum role: { user: 0, admin: 1 }

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  # Callbacks
  before_save :downcase_email

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.current
    save!
  end

  def reset_password_token_valid?
    reset_password_sent_at && reset_password_sent_at > 2.hours.ago
  end

  def clear_reset_password_token
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save!
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
