App.users = App.cable.subscriptions.create('UsersChannel', {  
  received: function(data) {
    return $('#user-table').append(this.renderUser(data));
  },

  renderUser: function(data) {
    return "<tr class='" + data.div_class + "'> <td class='text-center'>" + data.id +"</td><td>" + data.name +"</td>" + 
    "<td>" + data.email + "</td>"+ "<td>"+ data.phone +"</td>" + 
    "<td>" + data.city + "</td>" + 
    "<td>" + data.state + "</td>" + 
    "<td><div> <a class='btn btn-primary type='button' href='/admin/users/" + data.id + "'>" + data.btn_show + " </a></div></td></tr>"
  }
});