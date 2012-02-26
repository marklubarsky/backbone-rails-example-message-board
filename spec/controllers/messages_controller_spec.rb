require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MessagesController do

  describe "new" do
    before :each do            
      @message = 'foobar'
      Message.should_receive(:new).and_return(@message)      
      get :new
    end

    it "return the message" do      
      assigns(:message).should == @message
    end

    it "should contain a json representation of all messages in its response" do
      @response.body.should == @message.to_json
    end      
  end

  describe "edit" do
    before :each do            
      @message = 'foobar'
      @msg_id = 99  
      Message.should_receive(:find).with(@msg_id).and_return(@message)      
      get :edit, :id => @msg_id
    end

    it "return the message" do      
      assigns(:message).should == @message
    end

    it "should contain a json representation of all messages in its response" do
      @response.body.should == @message.to_json
    end      
  end

  describe "create" do
    before :each do            
      @message_attr = { 'message' => 'foobar' }
      Message.should_receive(:new).with(@message_attr['message']).and_return(@message = mock())      
    end

    it "should save the new message with all passed attributes" do
      @message.should_receive(:save).and_return(true)
      post :create, @message_attr
    end

    describe "when successful" do
      before :each do
        @message.should_receive(:save).and_return(true)        
        post :create, @message_attr
      end

      it "should return json with success code" do
        @response.body.should =~ /#{{:success => true}.to_json}/i
      end  
    end  

    describe "when fail" do
      before :each do
        @message.should_receive(:save).and_return(false)        
        @message.should_receive(:errors).and_return('foobar')
        post :create, @message_attr
      end

      it "should return json with failure code" do
        @response.status.should == 400
        @response.body.should =~ /#{{:error => 'foobar'}.to_json}/i
      end  
    end  

  end  

  describe "update" do
    before :each do            
      @message_attr = { 'message' => 'foobar' }
      @msg_id = 99  
      Message.should_receive(:find).with(@msg_id).and_return(@message = mock())      
    end

    it "should save the new message with all NEW passed attributes" do
      @message.should_receive(:update_attributes).and_return(true)
      post :update, @message_attr.merge(:id => @msg_id)
    end

    describe "when successful" do
      before :each do
        @message.should_receive(:update_attributes).and_return(true)        
        post :update, @message_attr.merge(:id => @msg_id)
      end

      it "should return json with success code" do
        @response.body.should =~ /#{{:success => true}.to_json}/i
      end  
    end  

    describe "when fail" do
      before :each do
        @message.should_receive(:update_attributes).and_return(false)        
        @message.should_receive(:errors).and_return('foobar')
        post :update, @message_attr.merge(:id => @msg_id)
      end

      it "should return json with failure code" do
        @response.status.should == 400
        @response.body.should =~ /#{{:error => 'foobar'}.to_json}/i
      end  
    end  
  end

  describe "destroy" do
    before :each do            
      @msg_id = 99  
    end

    describe "if message found" do
      before :each do
        Message.should_receive(:find).with(@msg_id).and_return(@message = mock())      
      end  

      it "should destroy the message" do
        @message.should_receive(:destroy)
        delete :destroy, :id => @msg_id
      end

      it "should return success code" do
        @message.should_receive(:destroy)
        delete :destroy, :id => @msg_id        
        @response.body.should =~ /#{{:success => true}.to_json}/i
      end  
    end

    describe "if message not found" do
      before :each do
        Message.should_receive(:find).with(@msg_id).and_raise('BOO!')      
      end  

      it "should raise error without trying to destroy the message" do
        @message.should_not_receive(:destroy)
        lambda { delete :destroy, :id => @msg_id}.should raise_error('BOO!')
      end
    end
  end



  describe "index" do
    describe "when format is HTML" do
      before :each do
        get :index, :format => :html
      end  

      it "should return index page" do
        @response.should render_template("index")
      end  
      
      it "should not try to load any data at first since the rea data will be loaded via ajax" do
        assigns(:messages).should be_nil
      end  
    end  

    describe "when format is JS" do
      before :each do            
        @ordered_messages = ['foo','bar']      
        Message.should_receive(:order).with("last_posted_at DESC").and_return(@ordered_messages)      
        get :index, :format => :js
      end

      it "return all messages ordered by posted date" do      
        assigns(:messages).should == @ordered_messages
      end

      it "should contain a json representation of all messages in its response" do
        @response.body.should == @ordered_messages.to_json
      end  
    end  
  end    
end
