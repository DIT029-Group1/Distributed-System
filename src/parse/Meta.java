package parse;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Meta {

@SerializedName("format")
@Expose
private String format;
@SerializedName("version")
@Expose
private String version;
@SerializedName("extensions")
@Expose
private List<Object> extensions = null;

public String getFormat() {
return format;
}

public void setFormat(String format) {
this.format = format;
}

public String getVersion() {
return version;
}

public void setVersion(String version) {
this.version = version;
}

public List<Object> getExtensions() {
return extensions;
}

public void setExtensions(List<Object> extensions) {
this.extensions = extensions;
}

}