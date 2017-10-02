/**
  * Author:Martin Chukaleski
  */
//Class that represents the actor in the sequence diagram
package Console;

public class Actor {
	private String aClass;
	private String name;
	
	public Actor(String actor,String name){
		this.aClass=actor;
		this.name=name;
	}

	public String getaClass() {
		return aClass;
	}

	public void setaClass(String aClass) {
		this.aClass = aClass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}

	
	

