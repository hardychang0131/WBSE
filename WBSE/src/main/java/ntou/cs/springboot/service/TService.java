package ntou.cs.springboot.service;

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
		
		return repository.insert(tmp);
		
		}
	
	
	
	
}
