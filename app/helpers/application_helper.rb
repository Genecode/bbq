module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user.png')
    end
   end

  def devise_error_custom(resource)
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <p>#{sentence}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fas fa-#{icon_class}"
  end

  def current_user_can_subscrube?(model)
    !(user_signed_in? &&  model.user == current_user || model.subscribers.exists?(current_user.try(:id)))
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path('user.png')
    end
  end

  # Возвращает адерс рандомной фотки события, если есть хотя бы одна. Или ссылку
  # на дефолтную картинку.
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  # Аналогично event_photo, только возвращает миниатюрную версию
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

end
