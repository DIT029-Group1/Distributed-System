package Console;

import parse.*;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.List;

/**
 * Created by Mr.Horse on 2017-10-03.
 */
public class SaveTxt {

    ReadJSON readJSON = new ReadJSON();
    Result result = new Result();

    public void saveToText(){
        this.result = readJSON.readJson();
    }
    public static void main (String[] args) throws FileNotFoundException, IOException{
        //SaveTxt saveTxt = new SaveTxt();
        //saveTxt.saveToText();
        ReadJSON readJSON = new ReadJSON();
        Result result = readJSON.readJson();
        String tempR = "";

        if (result != null) {
            tempR += "\n";
            tempR += "\n";
            tempR += "DIAGRAM:";
            tempR += "\n";

            List<Content> contents = result.getDiagram().getContent();
            int iterator = 0;
            for(Content content : contents){
                if(iterator>0){
                    tempR += "\n\nSUBDIAGRAM " + iterator + "\n\n";
                }

                for(Content_ c : content.getContent()) {
                    List<String> message = c.getMessage();
                    tempR += "\nfrom: "+ c.getFrom() + "  ----";
                    for(String msg:message){
                        tempR += "--" + msg + "--";
                    }
                    tempR += "---> to: "+ c.getTo() + "\n";
                }

                iterator++;
            }
        }


        ObjectOutputStream out = (new ObjectOutputStream(new FileOutputStream("OutTxt.txt")));

        out.writeObject(tempR);
    }
}
