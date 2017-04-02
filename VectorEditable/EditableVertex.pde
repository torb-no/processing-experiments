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

	public EditableVertex(float[] pointList) {
		this(pointList, new PVector(20, 20));
	}

	// Convert points relative to shape position to absolute positons on sketch
	// (apply position/offset)
	private float xO(float x) { return x + offset.x; }
	private float yO(float y) { return y + offset.y; }

	// Convert absolute positions on sketch to points relative to shape position
	// (remove position/offset)
	private float xA(float x) { return x - offset.x; }
	private float yA(float y) { return y - offset.y; }

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
					p.y = xA(mouseY);
					noExistingVerticesEdited = false;
					fill(255, 200);
				}
				else fill(255, 140);
				// TODO: be able to delte vertices (right click?) (only if more than 3 vertices)
			}
			else fill(255, 70);
			
			ellipse(xO(p.x), yO(p.y), CONTROL_CIRLCE_SIZE, CONTROL_CIRLCE_SIZE);
		}

		// Add the vertex
		// The algorithm here is pretty stupid and does
		// the wrong thing if you click on a line whose vertices
		// are further away than unrelated vertices
		if (noExistingVerticesEdited && mousePressed) {
			// Find the two closest vectors
			PVector closestP = points.get(0);
			PVector secClosestP = points.get(1);
			int closestI = 0;
			int secClosestI = 1;

			for (int i = 0; i < points.size(); ++i) {
				PVector p = points.get(i);
				if (dist(p.x, p.y, xA(mouseX), yA(mouseY)) < dist(closestP.x, closestP.y, xA(mouseX), yA(mouseY))) {
					secClosestI = closestI;
					secClosestP = closestP;
					closestP = p;
					closestI = i;
				}
				else if (dist(p.x, p.y, xA(mouseX), yA(mouseY)) < dist(secClosestP.x, secClosestP.y, xA(mouseX), yA(mouseY))) {
					secClosestI = i;
					secClosestP = p;
				}
			}

			// Add point between to closest vectors
			int insertIndex = (closestI > secClosestI) ? closestI : secClosestI;

			points.add(insertIndex, new PVector(xA(mouseX), yA(mouseY)));
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















