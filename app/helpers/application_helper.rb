module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'NateMate'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_user?(user)
    return false unless user == current_user

    true
  end

  def avatar_valid?(model)
    model.user.avatar.present?
  end

  def user_avatar_valid?(user)
    user.avatar.present?
  end

  def picture_valid?(model)
    model.picture.present?
  end
end
