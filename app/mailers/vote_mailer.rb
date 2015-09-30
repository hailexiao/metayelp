class VoteMailer < ApplicationMailer
  default from: 'notifications@metayelp.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Metayelp!')
  end

  def new_upvote(review)
    @review = review

    mail(
      to: review.user.email,
      subject: "Your review for #{review.yelper.name} has been upvoted #{review.upvotes.count}
         time(s)!"
    )
  end

  def new_downvote(review)
    @review = review

    mail(
      to: review.user.email,
      subject: "Your review for #{review.yelper.name} has been downvoted #{review.downvotes.count}
         time(s)!"
    )
  end

end
