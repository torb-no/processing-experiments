
import processing.net.*;

Server server;
JPGEncoder jpg;
PImage img;

final int TIMEOUT_MILLI = 1 * 3000;

void setup() {
	size(1400, 800);
	jpg = new JPGEncoder();
	// Start a server at port 5204
	server = new Server(this, 5203);

	background(0);
	img = createImage(100, 100, RGB);
	println("Starting server");

}

void draw() {
	checkForIncomingImage();
	image(img, 0, 0);
}


void checkForIncomingImage() {
	Client nextClient = server.available();

	if (nextClient != null && nextClient.available() >= 2) {
		println("More than two bytes available. Trying to get length.");

		// Taken from: https://processing.org/discourse/beta/num_1192330628.html
		int imageByteLength = nextClient.read()*256 + nextClient.read();

		println("Length is " + imageByteLength + ". Waiting for whole image.");
		int startMilli = millis();
		while (true) {
			// Wait for the image...

			// Abort if timeout has run out
			if ((millis() - startMilli) > TIMEOUT_MILLI) {
      	println("Timeout.");
      	nextClient.clear();
      	break;
      }

			// Load it if finished
      if (nextClient.available() >= imageByteLength) {
      	println("Enough in buffer, reading in...");
				byte[] jpgBytes = new byte[imageByteLength];
				nextClient.readBytes(jpgBytes);
				nextClient.clear();
				try {
					img = jpg.decode(jpgBytes);
				} 
				catch (IOException e) {
					println("IOException in reading jpgbytes");
				} 
				catch (NullPointerException e) {
					println("NullPointerException in reading jpgbytes");
				} 
				catch (ArrayIndexOutOfBoundsException e) {
					println("ArrayIndexOutOfBoundsException in reading jpgbytes");
				}
				finally {
					break;
				}
      }

		}

		

	}
}