package ntou.cs.springboot.entity;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "info")
public class Info {


    /**
     * date : 2020/6/8
     * name : 張xx
     * number : 00557105
     * note : 今天....
     * temperature : 35.4
     * class : 甲
     * grade : 3
     */
	private String id;
    private String date;
    private String name;
    private String number;
    private String note;
    private double temperature;
    private String classX;
    private String grade;
    private String status;
    
    public void setStatus(String status) {
		this.status = status;
	}
    public String getStatus() {
		return status;
	}
    
    
    public void setId(String id) {
		this.id = id;
	}
    public String getId() {
		return id;
	}
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public String getClassX() {
        return classX;
    }

    public void setClassX(String classX) {
        this.classX = classX;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
