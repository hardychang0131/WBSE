package ntou.cs.springboot.controller;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import ntou.cs.springboot.entity.Info;
import ntou.cs.springboot.service.TService;

@RestController
@RequestMapping(value = "/thermometer")
public class TController {
	@Autowired
	private TService Tservice;
		//學生送表單用
	 	@PostMapping("/student")
	    public ResponseEntity<Info> createInfo(@ModelAttribute Info request) {
		 
		 System.out.println(request.getClassX());
		 System.out.println(request.getDate());
		 System.out.println(request.getGrade());
		 System.out.println(request.getName());
		 System.out.println(request.getNote());
		 System.out.println(request.getTemperature());
		 System.out.println(request.getNote());
		 
		 Info info = Tservice.createInfo(request);

//	        URI location = ServletUriComponentsBuilder
//	                .fromCurrentRequest()
//	                .path("/{id}")
//	                .buildAndExpand(info.getNumber())
//	                .toUri();

	        return ResponseEntity.ok().body(info);
	    }
	
	 	//老師審核+學生修改當日表單用
	 	@PutMapping("/student")
	    public ResponseEntity<Info> updateInfo(@ModelAttribute Info request) {
		 
		 System.out.println(request.getClassX());
		 System.out.println(request.getDate());
		 System.out.println(request.getGrade());
		 System.out.println(request.getName());
		 System.out.println(request.getNote());
		 System.out.println(request.getTemperature());
		 System.out.println(request.getNote());
		 
		 Info info = Tservice.insertInfo(request);

//	        URI location = ServletUriComponentsBuilder
//	                .fromCurrentRequest()
//	                .path("/{id}")
//	                .buildAndExpand(info.getNumber())
//	                .toUri();

	        return ResponseEntity.ok().body(info);
	    }
	 	
	 	@PutMapping("/teacher")
	    public ResponseEntity<Info> tupdateInfo(@ModelAttribute Info request) {
		 
		 System.out.println(request.getClassX());
		 System.out.println(request.getDate());
		 System.out.println(request.getGrade());
		 System.out.println(request.getName());
		 System.out.println(request.getNote());
		 System.out.println(request.getTemperature());
		 System.out.println(request.getNote());
		 
		 Info info = Tservice.insertInfo(request);

//	        URI location = ServletUriComponentsBuilder
//	                .fromCurrentRequest()
//	                .path("/{id}")
//	                .buildAndExpand(info.getNumber())
//	                .toUri();

	        return ResponseEntity.ok().body(info);
	    }
	 	
	 	
	 	//老師查看所有學生表單
		@GetMapping("/teacher")
		public ResponseEntity<List<Info>> findbyid(){
			return ResponseEntity.ok().body(Tservice.findinfo());
		}
	    
		//學生查看歷史表單
		@GetMapping("/student/{id}")
		public ResponseEntity<List<Info>> findbystudentid(@PathVariable("id")String  id){
			
			return ResponseEntity.ok().body(Tservice.findinfo(id));
		}
	
}
