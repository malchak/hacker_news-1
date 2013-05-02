class Comment < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :post

  validates :content, :presence => true

  def vote_count
    CommentVote.where("comment_id = ?", self.id)
  end

  def author
    User.find(self.user_id)
  end

  def time_ago
    time = (Time.now - self.created_at) 
    if time > 86400
      "#{time.to_i/86400} days ago"
    elsif time > 7200
      "#{time.to_i/3600} hours ago"
    elsif time > 3600
      "#{time.to_i/3600} hour ago"
    elsif time > 60
      "#{time.to_i/60} minutes ago"
    else 
      "just now"
    end
  end

end
