import processing.net.*;

Client client;

void setup() {
	size(200, 200);
	client = new Client(this, "127.0.0.1", 5204);
	
	background(255);
}

void draw() {
	if (mousePressed) {
		ellipse(mouseX, mouseY, 10, 10);
	}
}

void mouseReleased() {
	client.write(mouseX + "," + mouseY);
}