require 'spec_helper'

describe Message do
  before :each do
    @message = Message.new(:title => 'How do I know Zeenat Aman', :body =>'Zeenat Aman played in Alibaba Aur 40 Chor with russian crew when I was a little boy in Uzbekistan. My 12 year-old brother was her translator!', :last_posted_by => 'anonymous')
    @message.should be_valid
    @message.save
    @message.updated_at.should_not be_nil
  end  

  it "should automatically set last_posted_at" do   
    @message.last_posted_at.to_s.should == @message.updated_at.to_s
    @message.should be_valid
  end   
  
  it "should require last_posted_by" do
    @message.last_posted_by = nil
    @message.should_not be_valid
  end
  
  it "should require title" do
    @message.title = nil
    @message.should_not be_valid
  end
  
  it "should require body" do
    @message.title = nil
    @message.should_not be_valid
  end

end
