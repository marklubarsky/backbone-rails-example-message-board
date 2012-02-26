App.EditMessageView = App.BaseCreateEditMessageView.extend({
	isCreateNew: false,

	events:	{
		"submit #editMessageForm" : "createOrUpdate",
		"click #editMessageForm button.delete" : "delete" 
	},

	initialize: function() {						
		this.collection.bind('edit', this.render, this);
		this.collection.bind('change', this.changed, this);
	},
	
	setModel: function(model) {
		this.model = model;
	},

	changed: function() { 
		this.collection.fetch(); 
	},

	delete: function() {
		this.collection.remove(this.model);
		this.unrender();
	},		
});