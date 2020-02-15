module UsersHelper

    def follow_exchanged?(user)
        return false unless user.following?(current_user) && current_user.following?(user)

        true
    end

    def allowed_to_edit?(user)
        return false unless user == current_user && user.name != 'guest'

        true
    end
end