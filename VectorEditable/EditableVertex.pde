import java.util.List;
import java.util.ArrayList;

class EditableVertex {

	List<PVector> points;

	public EditableVertex (float[] pointList, PVector offset) {
		points = new ArrayList();

		for (int i = 0; i+1 < pointList.length; i+=2) {
			points.add(new PVector(pointList[i] + offset.x, pointList[i+1] + offset.y));
		}
	}

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
			ellipse(p.x, p.y, 3, 3);

			final int CONTROL_CIRLCE_SIZE = 25;
			if (dist(p.x, p.y, mouseX, mouseY) < CONTROL_CIRLCE_SIZE) {
				if (mousePressed) {
					p.x = mouseX;
					p.y = mouseY;
					noExistingVerticesEdited = false;
					fill(255, 200);
				}
				else fill(255, 140);
			}
			else fill(255, 70);
			
			ellipse(p.x, p.y, CONTROL_CIRLCE_SIZE, CONTROL_CIRLCE_SIZE);
		}
	}

	public void display() {
		noFill();
		stroke(255, 200);
		beginShape();
		for (PVector p : points) {
			vertex(p.x, p.y);
		}
		endShape(CLOSE);
	}


}