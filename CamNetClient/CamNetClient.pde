import processing.net.*;
import processing.video.*;

Client client;
Capture cam;
JPGEncoder jpg;

void setup() {
	jpg = new JPGEncoder();

	cam = new Capture(this, Capture.list()[1]);
	cam.start();

	client = new Client(this, "127.0.0.1", 5204);
	
	background(255);
	println("Starting client");
}

void draw() {

}

void keyTyped() {
	if (cam.available()) {
		println("Cam available. Going to read");
		cam.read();
		try {
			println("Getting image to memory");
			PImage img = cam.get();

			println("Encoding");
			byte[] encoded = jpg.encode(img);

			println("Writing to server");
			client.write(encoded);
		} catch (IOException e) {
			// Ignore failure to encode
			println("IOException");
		}
		
		
	}
}
