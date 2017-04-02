import java.util.List;
import java.util.ArrayList;

class EditableVertex {

	PVector offset;
	List<PVector> points;

	public EditableVertex (float[] pointList, PVector position) {
		points = new ArrayList();

		for (int i = 0; i+1 < pointList.length; i+=2) {
			points.add(new PVector(pointList[i], pointList[i+1]));
		}

		this.offset = position;
	}

	// Convert points relative to shape position to absolute positons on sketch
	// (apply position/offset)
	private float xO(float x) { return x + offset.x; }
	private float yO(float y) { return y + offset.y; }

	// Convert absolute positions on sketch to points relative to shape position
	// (remove position/offset)
	private float xA(float x) { return x - offset.x; }
	private float yA(float y) { return y - offset.y; }

	public EditableVertex(float[] pointList) {
		this(pointList, new PVector(20, 20));
	}

	public void interactiveDisplay() {
		display();

		noStroke();
		ellipseMode(RADIUS);
		boolean noExistingVerticesEdited = true;
		for (PVector p : points) {
			fill(255);
			ellipse(xO(p.x), yO(p.y), 3, 3);

			final int CONTROL_CIRLCE_SIZE = 25;
			if (dist(p.x, p.y, xA(mouseX), yA(mouseY)) < CONTROL_CIRLCE_SIZE) {
				if (mousePressed) {
					p.x = xA(mouseX);
					p.y = yA(mouseY);
					noExistingVerticesEdited = false;
					fill(255, 200);
				}
				else fill(255, 140);
			}
			else fill(255, 70);
			
			ellipse(xO(p.x), yO(p.y), CONTROL_CIRLCE_SIZE, CONTROL_CIRLCE_SIZE);
		}
	}

	public void display() {
		noFill();
		stroke(255, 200);
		beginShape();
		for (PVector p : points) {
			vertex(xO(p.x), yO(p.y));
		}
		endShape(CLOSE);
	}


}