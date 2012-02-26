App.CreateMessageView = App.BaseCreateEditMessageView.extend({
	isCreateNew: true,

	events:	{	
		"submit #newMessageForm" : "createOrUpdate"
	},

	initialize: function() {
		this.collection.bind('add', this.added, this); 
	},	

	added: function() { this.collection.fetch(); },
});