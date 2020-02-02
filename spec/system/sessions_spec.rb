require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
    before do
        @user = create(:user)
    end

    it 'ログインページの要素検証' do
      visit '/sign_in'

      expect(page).to have_selector 'h2', text: 'ログイン'
      expect(page).to have_field 'メールアドレス'
      expect(page).to have_field 'パスワード'
      expect(page).to have_unchecked_field('ログイン状態を保存')
      expect(page).to have_button 'ログイン'
      expect(page).to have_button 'おためしログイン'
      expect(page).to have_link '新規登録'
      expect(page).to have_link 'パスワードを忘れてしまったら'
      expect(page).to have_link '認証メールが届かない場合はこちら'
    end

  describe '#new' do
    context 'ログインページで' do
      it 'email,passwordの両方が正しい場合、ログインが可能' do
        visit '/sign_in'
        #email,password共に未入力
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        #誤ったemail
        fill_in 'メールアドレス', with: 'invalidemail@sample.com'
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        #誤ったpassword
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: 'invalidpass'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        #有効なemail,password
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
        expect(page).to have_content 'マイページ'
      end

      it 'メール認証の完了していないユーザーのログインを許可しない' do
        unconfirmed_user = create(:user, :unconfirmed_user)

        visit '/sign_in'

        fill_in 'メールアドレス',with: unconfirmed_user.email
        fill_in 'パスワード',with: unconfirmed_user.password
        click_button "ログイン"
        expect(page).to have_content 'メールアドレスの本人確認が必要です。'
      end

      it 'おためしログインボタンを押すとゲストユーザーとしてログイン可能' do
        guest = create(:user, :guest)

        visit '/sign_in'

        click_button 'おためしログイン'
        expect(page).to have_content 'マイページ'
      end
    end
  end

  describe '#destroy' do
    context 'ログアウトリンクから' do
      it 'ログアウトが可能である',js: true do
        visit '/sign_in'

        fill_in 'メールアドレス',with: @user.email
        fill_in 'パスワード',with: @user.password
        click_button 'ログイン'
        expect(page).to have_content 'コレクション'

        #ヘッダーのドロップダウンを開く
        find('.fa-align-justify').click
        click_link 'ログアウト'
        expect(page.driver.browser.switch_to.alert.text).to eq 'ログアウトしてよろしいですか？'
        page.driver.browser.switch_to.alert.accept

        #未ログイン状態のrootへリダイレクトされているか
        expect(current_path).to eq root_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ログイン状態で変化するページ' do
    context '未ログイン状態では' do
      it '未ログインユーザー用のページが表示される' do
        visit root_path
        expect(page).to have_content 'ログイン'
      end

      it 'ユーザー詳細ページにアクセスできない' do
        visit '/users/1'
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end

      it '新規投稿ページにアクセスできない' do
        visit '/microposts/new'
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end

      it 'ユーザー検索ページにアクセスできない' do
        visit '/users'
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end

      it 'ユーザー情報編集ページにアクセスできない' do
        visit 'users/edit'
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'ログイン状態では' do
      it 'ログイン、新規登録ページにアクセスできない' do
        visit '/users/sign_in'

        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
        expect(page).to have_content 'マイページ'

        visit '/users/sign_in'
        expect(current_path).to eq user_path(@user)

        visit '/users/sign_up'
        expect(current_path).to eq user_path(@user)
      end
    end
  end

end