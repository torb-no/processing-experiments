import processing.video.*;

Capture cam;
PImage img;

void setup() {
	size(1400, 800);

	cam = new Capture(this, Capture.list()[1]);
	cam.start();
	img = createImage(100, 100, RGB);
}

void draw() {
	image(img, 0, 0);
}

void keyTyped() {
	if (cam.available()) {
		cam.read();
		img = cam.get();
	}
}