<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Chat</title>
	<!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hind&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" type="text/css" href="/css/chat.css">
	
	<script type="application/javascript">
	
		let ws;
		
        function connect() {
            ws = new WebSocket("ws://localhost:8080/chat");
            ws.onmessage = function (e) {
                printMessage(e.data);
            }
            document.getElementById("connectButton").disabled = true;
            document.getElementById("connectButton").value = "Connected";
            document.getElementById("name").disabled = true;
        }

        function printMessage(data) {
            let messages = document.getElementById("messages");
            let messageData = JSON.parse(data);
            let newMessage = document.createElement("div");
            newMessage.innerHTML = messageData.name + ": " + messageData.message;
            messages.appendChild(newMessage);
        }

        function sendToGroupChat() {
            let messageText = document.getElementById("message").value;
            document.getElementById("message").value="";
            let name = document.getElementById("name").value;
            let messageObject = {
                name: name,
                message: messageText
            }
            ws.send(JSON.stringify(messageObject))
        }
    </script>
    
</head>
<body>
	<div id="container">
		<h1>Chat Application</h1>
		<form class="message-content-body">
			<div class="section-1">
				<label for="name">Name: </label>
				<input type="text" id="name" placeholder="Enter your name"/>
				<input class="btn" id="connectButton" type="button" value="Connect" onclick="connect()">
			</div>
			<div id="messages" class="section-2"></div>
			<div class="section-3">
				<label for="message">Message: </label></br>
				<textarea id="message" rows="3" cols="100" placeholder='Type your message here'></textarea>
				<input class="btn" type="button" value="Send Message" onclick="sendToGroupChat()">	
			</div>
		</form>
	</div>
</body>
</html>