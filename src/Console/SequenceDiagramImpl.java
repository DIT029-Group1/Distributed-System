/**
  * Author:Martin Chukaleski
  */
package Console;
import java.util.ArrayList;

//A class that represents the sequence diagram and has all its data
public class SequenceDiagramImpl {
	ArrayList<Actor> actors = new ArrayList<Actor>(); //actors in the diagram
	ArrayList<Event> events = new ArrayList<Event>(); //events in the diagram
	ArrayList<SubDiagram> subdiagram = new ArrayList<SubDiagram>(); // subdiagrams in the diagram
	
	// a normal constructor for a seq Diagram
	public SequenceDiagramImpl(ArrayList<Actor> actors,ArrayList<Event> events,ArrayList<SubDiagram> SubDiagram){
		this.actors=actors;
		this.events=events;
		this.subdiagram=subdiagram;
	}
	
	// a constructor for a seq Diagram without subdiagrams
		public SequenceDiagramImpl(ArrayList<Actor> actors,ArrayList<Event> events){
			this.actors=actors;
			this.events=events;
			this.subdiagram=null;
		}
		
	public ArrayList<Actor> getActors() {
		return actors;
	}
	public void setActors(ArrayList<Actor> actors) {
		this.actors = actors;
	}
	public ArrayList<Event> getEvents() {
		return events;
	}
	public void setEvents(ArrayList<Event> events) {
		this.events = events;
	}
	public ArrayList<SubDiagram> getSubdiagram() {
		return subdiagram;
	}
	public void setSubdiagram(ArrayList<SubDiagram> subdiagram) {
		this.subdiagram = subdiagram;
	}
	
}
