void setup() {
	JPGEncoder jpg = new JPGEncoder();
	PImage srcImg = createImage(100, 100, RGB);
	srcImg.loadPixels();

	for (int i = 0; i < srcImg.pixels.length; ++i) {
		srcImg.pixels[i] = color(0, 90, 102);
	}

	byte[] imgbytes = null;

	try {
		imgbytes = jpg.encode(srcImg);
	} catch (Exception e) {
		println("e: " + e);
	}

	PImage targetImg = null;
	
	try {
		targetImg = jpg.decode(imgbytes);
	} catch (Exception e) {
		println("e: " + e);
	}
	
	image(targetImg, 0, 0, 100, 100);
}

void draw() {
	
}