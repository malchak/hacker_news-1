class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments

  validates :title, :content, :presence => true
  before_create :clean_title



  def clean_title
    self.title = title.split(" ").map { |x| x.capitalize }.join(" ")
  end


end
