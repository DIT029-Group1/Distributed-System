package Console;

/**
  * Author:Martin Chukaleski 02/10/2017
  */
import java.util.Scanner;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import parse.ReadJSON;
import sendEmail.*;

//Mock version for our application using the console
public class Console {

	private static ReadJSON rj = new ReadJSON();
	private static Scanner scan = new Scanner(System.in);

	public static void main(String[] args) {
		console();
	}

	public static void console() {
		print();
		String option = scan.nextLine();
		chooseOption(option);
	}

	public static void runEmail() {
		System.out.println("Type your email address:\n");
		String email = scan.nextLine();
		System.out.println("Checking if email is valid............\n");
		if (isValidEmailAddress(email)) {
			System.out.println("Email is valid, sending the file............\n");
			sendingAnEmail mail = new sendingAnEmail(email);
		} else {
			System.out.println("\nInvalid email please try again \n");
			runEmail();
		}

	}

	public static void chooseOption(String option) {

		switch (option) {

		case "1":
			System.out.println("Parsing JSON file");
			System.out.println("...........................................");
			rj.read();
			System.out.println("...........................................");
			goBack();
			break;
		case "2":
			System.out.println("Starting simulation");
			System.out.println("...........................................");
			// Call your function here
			goBack();
			break;
		case "3":
			System.out.println("Recording and saving simulation");
			System.out.println("...........................................");
			// Call your function here
			goBack();
			break;
		case "4":
			System.out.println("...........................................");
			// Call your function here
			runEmail();
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
		System.out.println("-----------------------------------------------------------");
		System.out.println("Press 1: TO parse JSON file ");
		System.out.println("Press 2: TO start simulation ");
		System.out.println("Press 3: TO record and save the simulation");
		System.out.println("Press 4: TO send the saved simulation to an email address");
		System.out.println("Type quit: TO exit the application");
		System.out.println("-----------------------------------------------------------");
		System.out.println("Type here: ");
	}

	public static void quit() {
		System.out.println("Application terminated");
		System.exit(0);
	}

	public static void back() {
		System.out.println("\n Going back to main menu \n");
		console();
	}

	public static void goBack() {
		System.out.println("-----------------------------------------------------------");
		System.out.println("To go back to main menu type: back");
		System.out.println("To exit the app type: quit\n");
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

	public static boolean isValidEmailAddress(String email) {
		boolean result = true;
		try {
			InternetAddress emailAddr = new InternetAddress(email);
			emailAddr.validate();
		} catch (AddressException ex) {
			result = false;
		}
		return result;
	}

}
