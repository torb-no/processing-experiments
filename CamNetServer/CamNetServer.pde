import processing.net.*;

Server server;
JPGEncoder jpg;
PImage img;

void setup() {
	size(1400, 800);
	jpg = new JPGEncoder();
	// Start a server at port 5204
	server = new Server(this, 5204);

	img = createImage(100, 100, RGB);
	println("Starting server");
}

void draw() {
	checkForIncomingImage();
	image(img, 0, 0);
}


void checkForIncomingImage() {
	Client nextClient = server.available();
	if (nextClient != null) {
		println("Client is available, reading bytes");

		byte[] byteBuffer = nextClient.readBytes();

		if (byteBuffer.length > 0) {
			println("Received data. Trying to decode.");
			try {
				img = jpg.decode(byteBuffer);
			} catch (IOException e) {
				println("IOException");
			} catch (NullPointerException e) {
				println("Probs incomplete image");
			} catch (ArrayIndexOutOfBoundsException e) {
				println("Probs also incomplete image (Out of Bounds)");
			}
		} else {
			println("Byte amount not above 0");
		}
	}
}