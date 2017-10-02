/**
  * Author:Martin Chukaleski
  */
//Class that handles the process events between them
public class Event {
	private String node;
	private Actor from; 
	private Actor to;
	private Message msg;
	
	public Event(String node,Actor from,Actor to,Message msg){
		this.node=node;
		this.from=from;
		this.to=to;
		this.msg=msg;
	}
	
	public Actor getFrom() {
		return from;
	}
	public void setFrom(Actor from) {
		this.from = from;
	}
	public Actor getTo() {
		return to;
	}
	public void setTo(Actor to) {
		this.to = to;
	}
	public Message getMsg() {
		return msg;
	}
	public void setMsg(Message msg) {
		this.msg = msg;
	}
	

}
