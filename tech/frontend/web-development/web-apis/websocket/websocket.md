## Reconnecting when connection dies

```javascript
function startWebsocket() {
  var ws = new WebSocket('ws://localhost:8080')

  ws.onmessage = function(e){
    console.log('websocket message event:', e)
  }

  ws.onclose = function(){
    // connection closed, discard old websocket and create a new one in 5s
    ws = null
    setTimeout(startWebsocket, 5000)
  }

  ws.onerror = function(){
    ws = null
    setTimeout(startWebsocket, 5000)
  }
}

startWebsocket();
```