/**
  * Author:Martin Chukaleski
  */
import java.util.Scanner;
//Mock version for our application using the console
public class Console {

	public static void main(String[] args) {
		console();
	}

	public static void console() {
		print();
		Scanner scan = new Scanner(System.in);
		String option = scan.nextLine();
		chooseOption(option);
		

	}
	public static void chooseOption(String option){
		Scanner scan = new Scanner(System.in);
		
		switch (option) {
		case "1":
			System.out.println("Parsing JSON file");
			System.out.println("...........................................");
			goBack();
			break;
		case "2":
			System.out.println("Starting simulation");
			System.out.println("...........................................");
			goBack();
			break;
		case "3":
			System.out.println("Recording and saving simulation");
			System.out.println("...........................................");
			goBack();
			break;
		case "4":
			System.out.println("Sending simulation ");
			System.out.println("...........................................");
			goBack();
			break;
		case "quit":
			quit();
			break;
		default:
			System.out.println("\n Invalid input please try again \n");
			String newOpt = scan.nextLine();
			chooseOption(newOpt);
		}
	}

	public static void print() {
		System.out.println("Welcome to our super fancy console of our first prototype");
		System.out.println("Press 1: TO parse JSON file ");
		System.out.println("Press 2: TO start simulation ");
		System.out.println("Press 3: TO record and save the simulation");
		System.out.println("Press 4: TO send the saved simulation");
		System.out.println("Type quit: TO exit the application\n");
	}

	public static void quit() {
		System.out.println("Application terminated");
		System.exit(0);
	}
	public static void back() {
		System.out.println("\n Going back to main menu \n");
		console();
	}
	
	public static void goBack(){
		System.out.println("To go back to main menu type: back");
		System.out.println("To exit the app type: quit");
		Scanner scan = new Scanner(System.in);
		String decision = scan.nextLine();
		switch (decision) {
		case "back":
			back();
			break;
		case "quit":
			quit();
			break;
		default:
			System.out.println("\nInvalid input please try again ");
			goBack();
		}
		
		
	}
}
