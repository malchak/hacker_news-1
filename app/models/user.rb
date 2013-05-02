  class User < ActiveRecord::Base
  has_many :comments
  has_many :posts

  validates :name, :password, :presence => true
  validates :name, :uniqueness => true
  
  validate :password_length
  validate :name_length

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  

  def name_length
    unless name.length > 3
      errors.add(:name, "doesn't have enough characters.")
    end
  end

  def password_length
    unless password.length > 6
      errors.add(:password, "doesn't have enough characters.")
    end
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

  def karma
    posts = Post.find_by_user_id(self.id).count
    comments = Comment.find_by_user_id(self.id).count
    post_votes = PostVote.find_by_user_id(self.id).count
    comment_votes = CommentVote.find_by_user_id(self.id).count
    posts + comments + post_votes + comment_votes
  end
  
end
