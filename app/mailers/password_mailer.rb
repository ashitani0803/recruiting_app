class PasswordMailer < ApplicationMailer
	default from: 'no-replay@gmail.com'

    def send_password(user, password)
        @user = user
        @password = password
        mail(
            subject: "仮パスワードが発行されました",
            to: @user.email

        )
	end
end
