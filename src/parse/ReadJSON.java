package parse;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import com.google.gson.Gson;

public class ReadJSON {

	public static void main(String[] args) {

		Gson gson = new Gson();
		BufferedReader br = null;

		try {

			br = new BufferedReader(new FileReader("testFiles/ourJson.json"));
			Result result = gson.fromJson(br, Result.class);
			// Example of usage
			if (result != null) {
				System.out.println();
				Meta m = result.getMeta();
				System.out.println(m.getFormat() + " - " + m.getVersion() + " - " + result.getType());
				
				System.out.println();
				System.out.println("CLASSES:");
				System.out.println();
				
				for(Process p : result.getProcesses()) {
					System.out.println(p.getClass_() + " - " + p.getName());
				}
				
				System.out.println();
				System.out.println("DIAGRAM:");
				System.out.println();
												
				for(Content_ c : result.getDiagram().getContent().get(0).getContent()) {
					System.out.println(c.getFrom() + " -> " + c.getTo() + " - " + c.getNode() + " - \"" + c.getMessage().get(0) + " " + c.getMessage().get(1)  + " " + c.getMessage().get(2) + "\" ");
				}
				
				System.out.println();
				System.out.println("SUB-DIAGRAM");
				System.out.println();
				
				for(Content_ c : result.getDiagram().getContent().get(1).getContent()) {
					System.out.println(c.getFrom() + " -> " + c.getTo() + " - " + c.getNode() + " - \"" + c.getMessage().get(0) + "\" ");
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

	public Result readJson(){

		Gson gson = new Gson();
		BufferedReader br = null;
		Result result = new Result();

		try {

			br = new BufferedReader(new FileReader("testFiles/ourJson.json"));
			result = gson.fromJson(br, Result.class);
			if(result!=null){
				return result;
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

		return result;
	}
}
