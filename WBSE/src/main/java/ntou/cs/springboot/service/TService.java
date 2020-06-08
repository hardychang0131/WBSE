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
	
	@Autowired
	private Handler handler;
	
	public TService(TRepository repository,Handler handler) {
		this.repository = repository;
		this.handler = handler;
	}
	
	public Info createInfo(Info info) {
		
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
