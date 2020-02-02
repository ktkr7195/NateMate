require 'rails_helper'

RSpec.describe 'Microposts', type: :system, js: true do

  describe '#new,#show,#destroy' do
    context 'ログインしたとき' do
      before do
        @user = create(:user)
        visit '/sign_in'
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
        expect(page).to have_content 'コレクション'

      end

      it '新規投稿ページの要素が正しく表示される' do
        visit '/microposts/new'

        expect(page).to have_selector 'h1',text: '新しいコレクション'
        expect(page).to have_field 'js_presentImg',visible: false
        expect(page).to have_field placeholder:'この写真にタイトルをつけましょう！(20字以内)'
        expect(page).to have_field placeholder:'  この写真についてもっと教えてください！(140字以内)'
        expect(page).to have_button '投稿する！'
      end

      it '新規投稿、投稿削除が可能' do
        visit '/microposts/new'

        attach_file 'js_presentImg',"#{Rails.root}/spec/fixtures/test.jpg", visible: false
        find('.form-control').set('sample_title')
        find('.form-area').set('sample_content')
        click_button '投稿する！'

        #ユーザーページにリダイレクトされるか
        expect(current_path).to eq user_path(@user)

        #投稿が保存されているか
        @micropost = Micropost.first
        expect(@micropost.title).to eq('sample_title')
        expect(@micropost.content).to eq('sample_content')

        #投稿詳細ページに遷移
        visit "/microposts/#{@micropost.id}"
        expect(page).to have_selector 'h2',text: @micropost.title

        #投稿の削除
        find('.fa-trash-alt').click
        expect(page.driver.browser.switch_to.alert.text).to eq "コレクションから「#{@micropost.title}」を削除します"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq user_path(@user)
        expect(Micropost.where(id: @user.id).count).to eq 0
      end
    end
  end
end