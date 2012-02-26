require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'As a message board visitor', :type => :request, :js => true do
  fixtures :messages

  shared_examples_for "original list of messages" do
    it "should show the list of messages" do 
      page.should have_content('Barack Obama')
      page.should have_content('Undisclosed')
      page.should have_content('George Bush')
      page.should_not have_content('Michelle Obama')
    end
    
    it "should show the last posted date in a proper format" do 
      expected_line_2 = "Posted February 26, 2012 @ 1:20PM by Barack Obama"
      page.find("#message-list .message-row:contains('Barack Obama') li.line2").should have_content(expected_line_2)
    end
    
    it "should show the title" do 
      page.find("#message-list .message-row:contains('Barack Obama') li.line1").should have_content('Who knows backbone.js?')
    end
  end

  shared_examples_for "final list of messages" do
    it "should show the list of messages" do 
      page.should have_content('Barack Obama')
      page.should have_content('Michelle Obama')
    end
  end

  describe "when I go to the index page" do
    before :each do      
      visit messages_path      
    end 

    it_should_behave_like "original list of messages"  

    describe "Then when I delete a message" do
      before :each do
        page.find("#message-list .message-row:contains('Undisclosed') button.remove").click    
      end 

      it "should show the list with that message removed" do
        page.should have_content('Barack Obama')
        page.should_not have_content('Undisclosed')
      end  
    end
    # 
    describe "Then when I click on to create a new message" do
      before :each do
        click_on "Submit New Posting"
      end 

      it "should show the form to create a new message" do
        page.should have_css("#create-edit-message form#newMessageForm")        
      end  

      it "should keep the message list" do
        page.should have_css("#message-list .message-row:contains('Barack Obama')")        
      end


      describe "Then when I create a new message" do
        before :each do
          fill_in "title", :with => "Stop fooling around!"
          fill_in "name", :with => "Michelle Obama"
          fill_in "body", :with => "Boys, get back to work!"
          click_on "Submit"
        end

        it "should show that new message added in the message list and remove the form" do
          page.should have_css("#message-list .message-row:contains('Michelle Obama')")        
          page.should_not have_css("#create-edit-message form#newMessageForm")        
        end

      end
    end
    # 
    describe "Then when click to edit a message" do
      before :each do
        page.find("#message-list .message-row:contains('Barack Obama') button.edit").click    
        page.should have_css("#create-edit-message form#editMessageForm")
      end 

      it "should open an edit form for this message" do
        page.should have_css("#create-edit-message form#editMessageForm input")
      end  

      it "should show existing values in all form fields" do
        page.find('#create-edit-message form#editMessageForm').should have_content('We are looking for experts in Backbone.js to fix our economy')        
      end

      describe "Then I edit fields and submit" do
        before :each do
          fill_in "title", :with => "We have given up looking for developers anymore. Apparently they cannot fix the economy!"
          click_on "Submit"
        end  

        it "should show that change in the message list" do
          page.should have_css("#message-list .message-row:contains('We have given up looking for developers anymore. Apparently they cannot fix the economy!')")        
          page.should_not have_css("#message-list .message-row:contains('We are looking for experts in Backbone.js to fix our economy')")        
        end

        it "should remove the form" do
          page.should_not have_css("#create-edit-message form#editMessageForm")        
        end
      end
    end

    describe "Then when I click to edit again" do
      before :each do
        page.find("#message-list .message-row:contains('George Bush') button.edit").click    
      end  

      describe "Then I delete this message" do
        before :each do
          page.should have_css("#create-edit-message form#editMessageForm")
          page.find("#create-edit-message form#editMessageForm button.delete").click        
        end

        it_should_behave_like "final list of messages"  

      end
    end    

    describe "Then when I refresh the page again" do
      before :each do
        visit messages_path
      end  

      it_should_behave_like "final list of messages"  
    end  
  end
end
