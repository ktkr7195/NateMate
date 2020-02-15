module UsersHelper

    def f4f?(user)
        return false unless user.following?(current_user) && current_user.following?(user)

        true
    end
end