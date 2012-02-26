App.MessageListView = Backbone.View.extend({
	el: '#message-list',
	events: { "click li.header button#newMessage"             : "new" },
	initialize: function() {
		_.bindAll(this, 'render');
		this.collection.bind('reset', this.render, this);
    this.collection.bind('remove', this.removed, this);
		this.collection.fetch();
		this.newMessageView = new App.CreateMessageView({collection: this.collection});		
		this.editMessageView = new App.EditMessageView({collection: this.collection});
	},	
	
	new: function() {
		this.newMessageView.render();
	},
	
	removed: function() {
		this.collection.fetch();
	},
	
	render: function() {
		container = $(this.el);		
		container.empty();				
		container.prepend('<ul><li class="header"><button id="newMessage">Submit New Posting</button></li></ul>');
		container = container.find('ul');
		
		var messageListView = this;
		
		this.collection.each(function(message) {													
			var messageView = new App.MessageRowView({ model: message });
			container.append(messageView.render().el);
		});
	}
});