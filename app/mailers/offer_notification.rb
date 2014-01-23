class OfferNotification < ActionMailer::Base
  default from: "do-not-reply@shred-list.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notification.make_offer.subject
  #
  def make_offer(user)
    @user = user
    @url = 'www.shred-list.com'
    mail to: @user.email,
      subject: 'Someone made an offer on your listing!'
  end
end
