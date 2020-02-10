FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "sample#{n}" }
    sequence(:email)        { |n| "sample#{n}@sample.com" }
    password                { 'password' }
    password_confirmation   { 'password' }
    confirmed_at            { Date.today }

  trait :guest do
    name     { 'guest' }
    email    { 'guest@guest.com' }
    password { 'password' }
  end

  trait :unconfirmed_user do
    name  { 'uncomfirmed' }
    email { 'unconfirmed@user.com' }
    password { 'password' }
    confirmed_at { nil }
  end

  trait :admin do
    name     { 'admin' }
    email    { 'admin@admin.com' }
    password { 'password' }
    admin    { true }
  end

  end
end
