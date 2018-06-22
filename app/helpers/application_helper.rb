module ApplicationHelper
  def user_avatar(user)
    #TODO load users photo
    asset_path('user.png')
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
    !(user_signed_in? &&  model.user == current_user || model.subscribers.exists?(current_user.id))
  end

end
