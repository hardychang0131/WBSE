package ntou.cs.springboot.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ntou.cs.springboot.repository.SRepository;
import ntou.cs.springboot.repository.TRepository;
import ntou.cs.springboot.entity.Handler;
import ntou.cs.springboot.entity.Info;
import ntou.cs.springboot.entity.Student;


@Service
public class TService {
	
	@Autowired
	private TRepository repository;
	@Autowired
	private SRepository srepository;

	
	public TService(TRepository repository) {
		this.repository = repository;
		this.srepository = srepository;
	}
	
	public Info createInfo(Info info) {
		
//		 System.out.println(info.getClassX());
//		 System.out.println(info.getDate());
//		 System.out.println(info.getGrade());
//		 System.out.println(info.getName());
//		 System.out.println(info.getNote());
//		 System.out.println(info.getTemperature());
//		 System.out.println(info.getNote());
		
		
		Info tmp = new Info();
		tmp.setNote(info.getNote());
		tmp.setClassX(info.getClassX());
		tmp.setDate(info.getDate());
		tmp.setGrade(info.getGrade());
		tmp.setNumber(info.getNumber());
		tmp.setName(info.getName());
		tmp.setTemperature(info.getTemperature());
		tmp.setStatus("尚未審核");
		return repository.insert(tmp);
		
		}
	
	public Student createstudent(Student student) {
		
		
		
		Student tmp = new Student();
		tmp.setNumber(student.getNumber());
		System.out.println(tmp.getNumber());
		return srepository.insert(tmp);
		
		}
	
	
	
	
	public Info insertInfo(Info info) {
		
		 System.out.println(info.getClassX());
		 System.out.println(info.getDate());
		 System.out.println(info.getGrade());
		 System.out.println(info.getName());
		 System.out.println(info.getNote());
		 System.out.println(info.getTemperature());
		 System.out.println(info.getNumber());
		 
		Info old = new Info();
		old =repository.findbyidforone(info.getNumber(),info.getDate()).findFirst().orElse(null); 
		if(old==null)
			System.out.println("isnull");
		old.setId(old.getId());
		old.setNote(info.getNote());
		old.setClassX(info.getClassX());
		old.setDate(info.getDate());
		old.setGrade(info.getGrade());
		old.setNumber(info.getNumber());
		old.setName(info.getName());
		old.setTemperature(info.getTemperature());
		old.setStatus("尚未審核");
		return repository.save(old);
		
		}

public Info tinsertInfo(Info info) {
		
		System.out.println(info.getClassX());
		 System.out.println(info.getDate());
		 System.out.println(info.getGrade());
		 System.out.println(info.getName());
		 System.out.println(info.getNote());
		 System.out.println(info.getTemperature());
		 System.out.println(info.getNumber());
		 
		Info old = new Info();
		old =repository.findbyidforone(info.getNumber(),info.getDate()).findFirst().orElse(null); 
		if(old==null)
			System.out.println("isnull");
		old.setId(old.getId());
		old.setNote(info.getNote());
		old.setClassX(info.getClassX());
		old.setDate(info.getDate());
		old.setGrade(info.getGrade());
		old.setNumber(info.getNumber());
		old.setName(info.getName());
		old.setTemperature(info.getTemperature());
		old.setStatus("已審核");
		return repository.save(old);
		
		}
	
	
	public List<Info> findinfo(){
		
		return repository.findAll();
		
	}
	
	public List<Info> findinfo(String id){
		
		return repository.findbyid(id);
		
	}
	public List<Info> findinfobytoday(String date){
		
		return repository.findbydate(date);
		
	}
	
	
	
	public List<Info> findinfobydate(String date){
		
		return repository.findbytdate(date);
		
	}
	public String checktodayinfoservice(String date,String number) {
		String check ="";
		if(repository.findbyidforone(number,date).findFirst().orElse(null)!=null) {
//			System.out.println(repository.findbyidforone(number,date).findFirst().orElse(null).getDate());
			check = "今日已填寫表單";
		}else {
			check = "今日尚未填寫";
		}
		return check; 
	}
	
	
	
	
	public Info findinfobyidanddate(String number,String date) {
		return repository.findbyidforone(number,date).findFirst().orElse(null);
		
	}
	
	
	public List<String> findwhonowrite(String date ) {
		
		List<Student> students =  srepository.findAll();
		List<String> check = new ArrayList<>();
		for(int i =0;i<students.size();i++)
		{	
			System.out.println(students.get(i).getNumber());
		
			if(	repository.findcheckexist(date,students.get(i).getNumber()).findFirst().orElse(null)==null)
			{	
				
				System.out.println("in if");
				check.add(students.get(i).getNumber());
			}
			
		}	
		
		if(check==null)
			check.add("皆以填寫");
		
		for(int i =0;i<check.size();i++)
		{	
			System.out.println(check.get(i));
			
		
		}
		
		return check;
		
	}
	
}
