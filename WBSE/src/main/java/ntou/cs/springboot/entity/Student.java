package ntou.cs.springboot.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "student")
public class Student {
    /**
     * id : 1221
     * number : 121221
     */
	@Id
    private String id;
//    private String id;
    private String number;

//    public String getId() {
//        return id;
//    }

//    public void setId(String id) {
//        this.id = id;
//    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}