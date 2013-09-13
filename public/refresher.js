;(function(){
  var host = window.location.protocol + '//' + window.location.hostname;
  var reloader = io.connect( host, {port: 12345} );
  reloader.on("refresh", function(data) {
    location.reload()
  });
})();