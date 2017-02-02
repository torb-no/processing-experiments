import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;

void setup() {
	PImage srcImg = createImage(100, 100, RGB);
	srcImg.loadPixels();
	for (int i = 0; i < srcImg.pixels.length; ++i) {
		srcImg.pixels[i] = color(0, 90, 102);
	}

	byte[] imgbytes = null;
	try {
		imgbytes = PImageToJPG(srcImg);
	} catch (Exception e) {
		println("e: "+e);
	}

	PImage targetImg = null;
	try {
		targetImg = FromJPGBytes(imgbytes);
	} catch (Exception e) {
		println("e: "+e);
	}
	
	image(targetImg, 0, 0, 100, 100);
}

void draw() {
	
}

byte[] PImageToJPG(PImage img) throws IOException {
	ByteArrayOutputStream imgbaso = new ByteArrayOutputStream();
	ImageIO.write((BufferedImage) img.getNative(), "jpg", imgbaso);

	return imgbaso.toByteArray();
}

PImage FromJPGBytes(byte[] imgbytes) throws IOException {
	BufferedImage imgbuf = ImageIO.read(new ByteArrayInputStream(imgbytes));
	PImage img = new PImage(imgbuf.getWidth(), imgbuf.getHeight(), RGB);
	imgbuf.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
	img.updatePixels();

	return img; 
}