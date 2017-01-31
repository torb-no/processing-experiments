import processing.net.*;

Server server;
int val = 0;

void setup() {
	size(200, 200);
	// Start a server at port 5204
	server = new Server(this, 5204);

	background(0);
}

void draw() {

	Client nextClient = server.available();
	if (nextClient != null) {
		String incomingData = nextClient.readString();
		if (incomingData != null) {
			String[] coords = incomingData.split(",");
			int x = int(coords[0]);
			int y = int(coords[1]);
			ellipse(x, y, 10, 10);
		} 
	}

}