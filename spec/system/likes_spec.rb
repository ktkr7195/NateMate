require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
    describe '#create,#destroy' do
        it 'ユーザーが他の投稿をいいね、いいね解除できる' do
            markus = create(:user,
                            name:  'markus',
                            email: 'markus@email.com')
            post   = create(:micropost)

            visit '/sign_in'
            fill_in 'メールアドレス', with: markus.email
            fill_in 'パスワード', with: markus.password
            click_button 'ログイン'
            expect(page).to have_content 'コレクション'

            #投稿のページへ
            visit "/microposts/#{post.id}"
            expect(page).to have_content 'spec content'

            #いいねをするボタンを押す
            find('.like-btn').click
            expect(page).to have_selector '.liking-btn'
            expect(post.likes.count).to eq(1)

            #いいねを解除する
            find('.liking-btn').click
            expect(page).to have_selector '.like-btn'
            expect(post.likes.count).to eq(0)
        end
    end
end