class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:vkontakte]
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private
  def set_name
    self.name = "User #{rand(1000)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
        .update_all(user_id: self.id)
  end

  def self.find_for_vkontakte_oauth(access_token)
    # https://github.com/mamantoha/omniauth-vkontakte#authentication-hash
    # Мы достаем из этого объекта url и provider, вместе они формируют
    # уникального пользователя
    url = access_token.info.urls.Vkontakte
    provider = access_token.provider

    where(url: url, provider: provider).first_or_create! do |user|
      # В блоке мы прописываем пользователю имя, которое получили от ВКонтатке
      user.name = access_token.info.name
      # Формируем email из id пользователя ВКонтакте
      user.email = "#{access_token.uid}@vk.com"
      # И генерируем ему случайный надежный пароль
      # пользоваться им никто не будет, но формально по нему можно войти
      user.password = Devise.friendly_token[0,20]
    end
  end
end
