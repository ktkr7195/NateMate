require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end


  it 'ユーザー登録が可能である' do
    expect(build(:user)).to be_valid
  end

  it 'name,email,password,password_cofirmationがユーザー登録に必要である' do
    user = User.new(
      name:                   'sample user',
      email:                  'sample@sample.com',
      password:               'password',
      password_confirmation:  'password'
    )
    expect(user).to be_valid
  end


  it'nameが存在しないユーザーを許可しない' do
    @user.name = nil
    @user.valid?
    expect(@user.errors).to be_added(:name,:blank)
  end

  it "nameが空白のユーザーを許可しない" do
    @user.name = "   "
    @user.valid?
    expect(@user.errors).to be_added(:name,:blank)
  end

  it 'emailが存在しないユーザーを許可しない' do
    @user.email = nil
    @user.valid?
    expect(@user.errors).to be_added(:email,:blank)
  end

  it 'passwordが存在しないユーザーを許可しない' do
    @user.password = @user.password_confirmation = " " * 6
    @user.valid?
    expect(@user.errors).to be_added(:password,:blank)
  end

  it 'passwordとpassword_confirmationの一致しないユーザーを許可しない' do
    @user.password = 'password'
    @user.password_confirmation = 'aaaaaaaa'
    @user.valid?
    expect(@user.errors).to be_added(:password_confirmation,:confirmation,attribute: 'パスワード')
  end

  it 'nameが4文字未満のユーザーを許可しない' do
    @user.name='a' * 3
    @user.valid?
    expect(@user.errors).to be_added(:name, :too_short, count: 4)
  end

  it 'nameが4文字以上15文字以下のユーザーを許可する' do
    @user.name = 'a' * 5
    expect(@user).to be_valid
  end

  it 'nameが16文字以上のユーザーを許可しない' do
    @user.name = 'a' * 16
    @user.valid?
    expect(@user.errors).to be_added(:name, :too_long, count: 15)
  end

  it 'emailが255文字以下のユーザーを許可する' do
    @user.email = 'a' * 245 + '@sample.jp'
    expect(@user).to be_valid
  end

  it 'emailが256文字以上のユーザーを許可しない' do
    @user.email = 'a' * 246 + '@sample.jp'
    @user.valid?
    expect(@user.errors).to be_added(:email, :too_long, count: 255)
  end

  it 'passwordが6文字未満のユーザーを許可しない' do
    @user.password = 'a' * 5
    @user.valid?
    expect(@user.errors).to be_added(:password, :too_short, count: 6)
  end

  it 'passwordが６文字以上のユーザーを許可する' do
    @user.password = @user.password_confirmation = 'a' * 6
    expect(@user).to be_valid
  end

  it 'nameが一意でないユーザーを許可しない' do
    user  = create(:user, name: 'sample')
    user2 =  build(:user, name: 'sample')
    user2.valid?
    expect(user2.errors).to be_added(:name, :taken, value: 'sample')
  end

  it 'nameの一意性は大文字小文字を区別する' do
    user  = create(:user,name: 'jack')
    user2 =  build(:user,name: 'jAck')
    expect(user2).to be_valid
  end

  it 'emailが一意でないユーザーを許可しない' do
    user  = create(:user, email:'sample@sample.jp')
    user2 =  build(:user, email:'sample@sample.jp')
    user2.valid?
    expect(user2.errors).to be_added(:email, :taken,value:'sample@sample.jp')
  end

  it 'emailは全て小文字で保存される' do
    @user.email = 'SAMPLE@SAMPLE.JP'
    @user.save!
    expect(@user.reload.email).to eq 'sample@sample.jp'
  end


  it'ユーザーが他のユーザーをフォロー、フォロー解除可能である' do
    rei   = create(:user)
    asuka = create(:user)
    rei.follow(asuka)
    expect(rei.following?(asuka)).to eq true
    rei.unfollow(asuka)
    expect(rei.following?(asuka)).to eq false
  end

  it 'フォロー中のユーザーが削除されると、フォローが解消される' do
    rei   = create(:user)
    asuka = create(:user)
    rei.follow(asuka)
    expect(rei.following?(asuka)).to eq true
    asuka.destroy
    expect(rei.following?(asuka)).to eq false
  end

  it 'フォローされているユーザーが削除されると、フォローされていた状態が解消される' do
    rei   = create(:user)
    asuka = create(:user)
    rei.follow(asuka)
    expect(asuka.followers.include?(rei)).to eq true
    rei.destroy
    expect(asuka.followers.include?(rei)).to eq false
  end





end
