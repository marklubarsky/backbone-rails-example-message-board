App.MessageList = Backbone.Collection.extend({
	url: function() {
		return '/messages';
	},	
	model: App.Message,
	initialize: function() {
		this.bind("remove", function() {
			this.fetch();
		});					
	}
});