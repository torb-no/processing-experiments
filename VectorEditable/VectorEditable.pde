EditableVertex edVert;

void setup() {
	size(500, 500);
	edVert = new EditableVertex(new float[]{ 0,0,  100,0,  100,100,  0,100 });
}

void draw() {
	background(0);

	edVert.interactiveDisplay();
}