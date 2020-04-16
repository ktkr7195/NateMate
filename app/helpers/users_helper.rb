module UsersHelper

    #
    # 引数に指定したユーザーと相互フォローの関係性かどうか判定する
    # @return [Boolean] true 相互フォローしている / false 相互フォローしていない
    #
    def follow_exchanged?(user)
    return false unless user.following?(current_user) && current_user.following?(user)

    true
    end

    #
    # ユーザー情報が編集可能かどうか判定する(Guestユーザーは編集不可)
    # @return [Boolean] true 編集可 / false 編集不可
    #
    def allowed_to_edit?(user)
    return false unless user == current_user && user.name != 'guest'

    true
    end
end