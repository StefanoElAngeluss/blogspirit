# frozen_string_literal: true

class PostMailerPreview < ActionMailer::Preview
  def post_created
    PostMailer.with(user: User.first, post: Post.first).post_created
  end
end
