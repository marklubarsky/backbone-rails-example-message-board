App.Message = Backbone.Model.extend({
	urlRoot: '/messages',
	
	initialize: function() {
		this.bind("remove", function() {
			
		  this.destroy();
		});
	}
});
