module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'NateMate'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
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

  #
  # 引数に指定したユーザーがログイン中のユーザー自身かどうか判定する
  # @return [Boolean]
  #
  def current_user?(user)
    return false unless user == current_user

    true
  end

  #
  # 引数に指定したユーザーのアバター画像が設定されているか判定する
  # @return [Boolean]
  #
  def user_avatar_valid?(user)
    user.avatar.present?
  end

  #
  # 引数に指定した投稿を作成したユーザーのアバター画像が設定されているか判定する
  # @return [Boolean]
  #
  def avatar_valid?(model)
    model.user.avatar.present?
  end

  #
  # 引数に指定した投稿に画像(picture)が設定されているか判定する
  # @return [Boolean]
  #
  def picture_valid?(model)
    model.picture.present?
  end
end
