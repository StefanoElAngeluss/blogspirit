# frozen_string_literal: true

class PostMailer < ApplicationMailer
  default from: 'admin@blogspirit.com'
  layout '../post_mailer/post_created'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post_created.subject
  #
  def post_created
    @user = params[:user]
    @post = params[:post]
    @greeting = 'Bonjour'
    attachments.inline['time.png'] = File.read("#{Rails.root}/app/assets/images/time.png", mode: 'rb')
    # attachments['time.png'] = File.read('public/packs/assets/images/time.png')

    mail(
      from: 'BlogSpirit <support@blogspirit.com>',
      to: email_address_with_name(User.first.email, User.first.email),
      cc: User.all.pluck(:email),
      bcc: 'shane.walter@mail.com',
      subject: 'Nouvel article créer'
    )
  end
end
