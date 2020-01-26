require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { create(:micropost) }

  it 'micropostが投稿可能である' do
    expect(micropost).to be_valid
  end

  it 'ユーザーが存在しない投稿を許可しない' do
    micropost.user_id = nil
    micropost.valid?
    expect(micropost.errors).to be_added(:user_id, :blank)
  end

  it 'titleが存在しない投稿を許可しない' do
    micropost.title = nil
    micropost.valid?
    expect(micropost.errors).to be_added(:title, :blank)
  end

  it 'titleが空白の投稿を許可しない' do
    micropost.title = ' '
    micropost.valid?
    expect(micropost.errors).to be_added(:title, :blank)
  end

  it 'pictureが存在しない投稿を許可しない' do
    micropost.picture = nil
    micropost.valid?
    expect(micropost.errors).to be_added(:picture, :blank)
  end

  it '20文字以下のtitleを許可する' do
    micropost.title = 'a' * 20
    expect(micropost).to be_valid
  end

  it '21文字以上のtitleを許可しない' do
    micropost.title = 'a' * 21
    micropost.valid?
    expect(micropost.errors).to be_added(:title, :too_long, count: 20)
  end

  it '140字以下のcontent許可する' do
    micropost.content = 'a' * 140
    expect(micropost).to be_valid
  end

  it '141字以上のcontentを許可しない' do
    micropost.content = 'a' * 141
    micropost.valid?
    expect(micropost.errors).to be_added(:content, :too_long, count: 140)
  end
end
