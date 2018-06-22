class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> {user.present?}
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/ , unless: -> {user.present?}

  validates :user, uniqueness: {scope: :event_id}, if: -> {user.present?}
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> {user.present?}

  #Свой валидатор
  validate :anonymous_cant_subscribe_exist_user, on: :create
  validate :author_cant_subscribe, on: :create

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def anonymous_cant_subscribe_exist_user
    if user.blank? && User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t('errors.email_exist'))
    end
  end

  def author_cant_subscribe
    if user == event.user then
      errors.add(:user_name, I18n.t('errors.author'))
    end
  end
end
