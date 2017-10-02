/**
  * Author:Martin Chukaleski
  */
//A class representation for the messages in the sequence diagram
public class Message {
	private String label;
	private Actor actor;
	private String message;
	
	//Constructor for normal messages example ["fwd","u1",msg]
	public Message(String label,Actor actor,String message){
		this.label=label;
		this.actor=actor;
		this.message=message;
	}
	//Constructor for status or ok messages that dont contain a label or an actor
	public Message(String message){
		this.label=null;
		this.actor=null;
		this.message=message;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Actor getActor() {
		return actor;
	}

	public void setActor(Actor actor) {
		this.actor = actor;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
