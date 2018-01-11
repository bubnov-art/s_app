//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cable.js
$( document ).on('turbolinks:load', function() {
	$('#user_footer').on('click','.btn-r', function(){
		console.log("11s");
		uid = $(this).attr("name");
		$.post('/admin/users/change-state',{state: uid});
		window.location.reload();
	});
})
