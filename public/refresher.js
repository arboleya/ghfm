;(function(){
  var host = window.location.protocol + '//' + window.location.hostname;
  var reloader = io.connect( host, {port: 12345} );
  reloader.on("refresh", function(data) {
    var i, y = $(document).scrollTop();
    $('#ghfm').empty().append(data);
    $(document).scrollTop(y);
    clearInterval(i);
    i = setInterval(function()
    {
      $(document).scrollTop(y);
      if($(document).scrollTop() == y)
        clearInterval(i);
    }, 30);
    console.log('foi!');
  });
})();