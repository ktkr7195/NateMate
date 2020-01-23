User.create!(name: "guest",
             email: "guest@guest.com",
             password: "password",
             password_confirmation: "password",
             confirmed_at: Time.zone.now,
             confirmation_sent_at: Time.zone.now,
            )