class Message < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :last_posted_by
  before_save :set_last_posted_by
  
  def set_last_posted_by
    self.last_posted_at = Time.now
  end    
end
