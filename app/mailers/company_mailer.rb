class CompanyMailer < ApplicationMailer
    default from: 'no-replay@gmail.com'

    def send_mail(user, company)
        @user = user
        @company = company
        @url = "http://localhost:3000/companies/#{company.id}/users/#{@user.id}/become_employee"
        mail(
            subject: "社員登録認証",
            to: @user.email

        )
    end
end
