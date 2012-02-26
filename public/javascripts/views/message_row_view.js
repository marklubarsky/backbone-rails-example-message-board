App.MessageRowView = Backbone.View.extend({
	tagName: 'li',
	className: 'message-row',
	events:		
	{
		"click li.edit button"             : "edit",
		"click li.remove button"             : "delete"
	},

	edit: function(){		
		App.messageListView.editMessageView.setModel(this.model);
		App.messageListView.editMessageView.render();
	},

	delete: function(){
		this.model.collection.remove(this.model);
	},		
	
	render: function(){
		var template = _.template($("#message_row_template").html(), this.model.toJSON()); 
		$(this.el).html(template);
		return this;
	}
});