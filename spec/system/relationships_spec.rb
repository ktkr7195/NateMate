require 'rails_helper'

RSpec.describe 'Relationships', type: :system, js: true do
    describe '#create,#destroy' do
        it 'ユーザーをフォロー、フォロー解除できる' do
            hank    = create(:user,
                             name:  'hank',
                             email: 'hank@email.com')
            connor  = create(:user,
                             name:  'connor',
                             email: 'connor@email.com')

            # hankがログイン
            visit '/sign_in'
            fill_in 'メールアドレス', with: hank.email
            fill_in 'パスワード', with: hank.password
            click_button 'ログイン'
            expect(page).to have_content 'コレクション'

            visit user_path(connor)
            expect(page).to have_content 'connor'

            # connorをフォローする
            click_button 'フォローする'
            expect(page).to have_button 'フォロー中'
            expect(connor.followers.count).to eq(1)
            expect(hank.following.count).to eq(1)

            # connorをフォロー解除する
            click_button 'フォロー中'
            expect(page).to have_button 'フォローする'
            expect(connor.followers.count).to eq(0)
            expect(hank.following.count).to eq(0)
        end
    end
end