package parse;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import com.google.gson.Gson;

public class RaedJSON {

	public static void main(String[] args) {

		Gson gson = new Gson();
		BufferedReader br = null;

		try {

			br = new BufferedReader(new FileReader("testFiles/ourJson.json"));
			Result result = gson.fromJson(br, Result.class);
			// Example of usage
			if (result != null) {
				Meta m = result.getMeta();
				System.out.println(m.getFormat() + " - " + m.getVersion() + " - " + result.getType());
				
				System.out.println();
				
				for(Process p : result.getProcesses()) {
					System.out.println(p.getClass_() + " - " + p.getName());
				}
				
				System.out.println();
								
				System.out.println();
				
				for(Content_ c : result.getDiagram().getContent().get(0).getContent()) {
					System.out.println(c.getFrom() + " -> " + c.getTo() + " - " + c.getNode() + " - \"" + c.getMessage() + "\" ");
				}
				
				System.out.println();
				
				for(Content_ c : result.getDiagram().getContent().get(1).getContent()) {
					System.out.println(c.getFrom() + " -> " + c.getTo() + " - " + c.getNode() + " - \"" + c.getMessage() + "\" ");
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (br != null)
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}

}
