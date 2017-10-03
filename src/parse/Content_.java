package parse;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Content_ {

@SerializedName("node")
@Expose
private String node;
@SerializedName("from")
@Expose
private String from;
@SerializedName("to")
@Expose
private String to;
@SerializedName("message")
@Expose
private List<String> message = null;

public String getNode() {
return node;
}

public void setNode(String node) {
this.node = node;
}

public String getFrom() {
return from;
}

public void setFrom(String from) {
this.from = from;
}

public String getTo() {
return to;
}

public void setTo(String to) {
this.to = to;
}

public List<String> getMessage() {
return message;
}

public void setMessage(List<String> message) {
this.message = message;
}

}