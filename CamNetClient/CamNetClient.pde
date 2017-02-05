import processing.net.*;
import processing.video.*;

Client client;
Capture cam;
JPGEncoder jpg;

void setup() {
	jpg = new JPGEncoder();

	cam = new Capture(this, Capture.list()[1]);
	cam.start();

	// String server = "192.168.1.15";
	String server = "127.0.0.1";
	client = new Client(this, server, 5204);
	
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
			img.resize(500, 0);

			println("Encoding");
			byte[] encoded = jpg.encode(img, 0.1F);

			println("Writing to server");
			client.write(encoded);
		} catch (IOException e) {
			// Ignore failure to encode
			println("IOException");
		}
		
		
	}
}
