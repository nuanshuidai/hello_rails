class ContactMailer < ApplicationMailer
    def say_hello_to(user)
        @candidate = user
        mail to:@user.email, subject:"您好！这里从rails发来的邮件！"
        
    end
end
