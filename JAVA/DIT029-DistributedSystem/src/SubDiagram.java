/**
  * Author:Martin Chukaleski
  */
//Representation of Sub diagrams for example paralel or sequental
public class SubDiagram {
	private String diagramType;
	private SubDiagram diagram; // a subdiagram can also have its own subdiagram like the one in the example the "seq" in "par"
	
	public SubDiagram(String diagramNode,SubDiagram daigram){
		this.diagramType=diagramNode;
		this.diagram=diagram;
	}
	//Constructor for a subdiagram that doesnt contain a diagram inside it
	public SubDiagram(String diagramNode){
		this.diagramType=diagramNode;
		this.diagram=null;
	}
	public String getDiagramNode() {
		return diagramType;
	}
	public void setDiagramNode(String diagramNode) {
		this.diagramType = diagramNode;
	}
	public SubDiagram getDiagram() {
		return diagram;
	}
	public void setDiagram(SubDiagram diagram) {
		this.diagram = diagram;
	}

}
