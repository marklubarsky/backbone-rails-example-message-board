App.BaseCreateEditMessageView = Backbone.View.extend({
	el: '#create-edit-message',	
	
	createOrUpdate: function(data) {
		var titleField = $('input[name=title]');
		var nameField = $('input[name=name]');
		var bodyField = $('textarea[name=body]');

		var self = this;
		var method = this.isCreateNew ? this.collection.create : this.model.save;	
		
		method.call(this.model || this.collection, {
			message:	{title: titleField.val(), last_posted_by: nameField.val(), body: bodyField.val()}
		}, 
		{
			wait: true, 
			error: function(model, response) {
				alert(JSON.stringify(JSON.parse(response.responseText).error));
			},
			success: function(model, response) {
				self.unrender();				
			}
		});

		data.stopPropagation();
	},

	render: function(){
		var template_name = (this.isCreateNew ? "new" : "edit") + "_message_template";
		var model = this.model !== undefined ? this.model.toJSON() : {};

		$(this.el).html(_.template($('#' + template_name).html(), model));
		return this;
	},

	unrender: function(){
		$(this.el).empty();
	}
});