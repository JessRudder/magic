$(function() {
  // Here we instantiate a new WebSocketRails instance
  dispatcher = new WebSocketRails($('#echo').data('uri'), true)
  // We send the message when we push the 'send' button
  document.querySelector('button#fire').onclick = function() {
    send(document.querySelector('#send').value);
    document.querySelector('#send').value = '';
  };
  // We bind the incoming message event
  dispatcher.bind('new_message',
    function(message) {
      document.querySelector('#messages').innerHTML += '<li>' + message + '</li>';
    })
});
// Here we send the message in the websocket
function send(message) {
  dispatcher.trigger('new_message', message);
}