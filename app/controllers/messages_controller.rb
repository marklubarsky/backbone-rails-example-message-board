class MessagesController < ApplicationController

  def new
    @message = Message.new
    render :json => @message.to_json
  end

  def edit
    @message = Message.find(params[:id])
    render :json => @message.to_json
  end

  def create
    @message = Message.new(params[:message])

    if @message.save
      render :json => {:success => true} 
    else
      render :status => 400, :json => {:error => @message.errors}   
    end  
  end  

  def update
    @message = Message.find(params[:id])

    if @message.update_attributes(params[:message])
      render :json => {:success => true} 
    else
      render :status => 400, :json => {:error => @message.errors}   
    end  
  end

  def destroy
    @message = Message.find(params[:id])    
    @message.destroy
    render :json => { :success => true }
  end

  def index
    respond_to do |format|
      format.html #return just HTML page with JS templates
      format.js { 
        @messages = Message.order("last_posted_at DESC")
        render :json => @messages 
      }
    end
  end  

end
