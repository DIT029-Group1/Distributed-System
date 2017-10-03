package sendEmail;

import java.util.Properties;
import java.util.Scanner;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class sendingAnEmail {

	private static String email;
	private static String file;

	/**
	 * A constructor that uses the user's e-mail and the txt file.
	 */
	public sendingAnEmail(String file, String email) {
		this.email = email;
		this.file = file;

		final String username = "dit029management";
		final String password = "dit12345";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			/**
			 * A method for sending the Json file as an attachment.
			 **/
			// Create the message part
			BodyPart messageBodyPart = new MimeBodyPart();

			// Now set the actual message
			messageBodyPart
					.setText("Here's your Json file, " + "\n\n Best regards, " + "\n\n Dit029 management :) " + ".");

			// Create a multipar message
			Multipart multipart = new MimeMultipart();

			// Set text message part
			multipart.addBodyPart(messageBodyPart);

			// Part two is attachment

			messageBodyPart = new MimeBodyPart();
			String filename = "testFiles/hello.txt";
			DataSource source = new FileDataSource(filename);
			messageBodyPart.setDataHandler(new DataHandler(source));
			messageBodyPart.setFileName(filename);
			multipart.addBodyPart(messageBodyPart);

			// Send the complete message parts
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("dit029management@gmail.com"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("DIT029 MANAGEMENT");

			message.setContent(multipart);
			Transport.send(message);

			System.out.println("Msg has sent!");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	public static void main(String[] args) {
	    Scanner in = new Scanner(System.in);
		System.out.println("Please enter your email: ");
	    email = in.nextLine();
	    sendingAnEmail nnew = new sendingAnEmail(file, email);
	    
	}
}