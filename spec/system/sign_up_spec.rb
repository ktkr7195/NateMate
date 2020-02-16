require 'rails_helper'

RSpec.describe 'Sign_up', type: :system do

  it '新規登録ページの要素検証' do
    visit '/users/sign_up'

    expect(page).to have_selector 'h2',text: '新規登録'
    expect(page).to have_field 'js_presentImg',visible: false
    expect(page).to have_field 'ユーザーネーム'
    expect(page).to have_field 'メールアドレス'
    expect(page).to have_field 'パスワード'
    expect(page).to have_field 'パスワード再入力'
    expect(page).to have_button '登録する'
    expect(page).to have_link 'ログイン'
  end

  describe 'registrations#new' do
    it 'ユーザーを新規登録可能' do
      visit '/users/sign_up'

      fill_in 'ユーザーネーム',with: 'testuser'
      fill_in 'メールアドレス',with: 'sample@sample.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード再入力',with: 'password'
      click_button '登録する'

      # ログイン画面にリダイレクト
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content '認証用メールを送信しました'
    end

    it '各入力欄に適切な値が入力されていない新規登録を許可しない' do
      visit '/users/sign_up'

      fill_in 'ユーザーネーム',with: ''
      fill_in 'メールアドレス',with: 'invalid@invalid'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード再入力',with: 'invalidpass'
      click_button '登録する'
      expect(page).to have_content 'ユーザーネームを入力してください'
      expect(page).to have_content 'ユーザーネームは4文字以上で入力してください'
      expect(page).to have_content 'メールアドレスが正しく入力されていません'
      expect(page).to have_content 'パスワード再入力とパスワードの入力が一致しません'
    end
  end

end