package ntou.cs.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ntou.cs.springboot.repository.TRepository;
import ntou.cs.springboot.entity.Handler;
import ntou.cs.springboot.entity.Info;


@Service
public class TService {
	
	@Autowired
	private TRepository repository;
	
//	@Autowired
//	private Handler handler;
	
	public TService(TRepository repository) {
		this.repository = repository;
//		this.handler = handler;
	}
	
	public Info createInfo(Info info) {
		
		System.out.println(info.getClassX());
		 System.out.println(info.getDate());
		 System.out.println(info.getGrade());
		 System.out.println(info.getName());
		 System.out.println(info.getNote());
		 System.out.println(info.getTemperature());
		 System.out.println(info.getNote());
		
		
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
		old.setStatus(info.getStatus());
		return repository.save(old);
		
		}

	
	
	
	public List<Info> findinfo(){
		
		return repository.findAll();
		
	}
	
	public List<Info> findinfo(String id){
		
		return repository.findbyid(id);
		
	}

	
	
	
	
	
}
