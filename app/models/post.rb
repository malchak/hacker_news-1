class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments

  validates :title, :url, :presence => true
  before_create :clean_title

  def clean_title
    self.title = title.split(" ").map { |x| x.capitalize }.join(" ")
  end

  def author
    User.find(self.user_id).name
  end

  def vote_count
    count = PostVote.where("post_id = ?", self.id).count
    if count == 0
      "no votes yet"
    else
      count.to_s + " votes"
    end
  end

  def url_snippet
    URI(self.url).host.gsub(/www./,'')
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

  def comment_count
    count = Comment.where("post_id = ?", self.id).count
    if count == 0
      "discuss"
    else
      count.to_s + " comments"
    end
  end

end
