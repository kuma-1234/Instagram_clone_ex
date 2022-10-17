class ContactMailer < ApplicationMailer
  def contact_mail(blog)
    @blog = blog
    mail to: @blog.user.mail, subject: "投稿確認メール"
  end
end
