package ntou.cs.springboot.controller;

import java.net.URI;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
	
	 	//學生修改當日表單用
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
		 
		 Info info = Tservice.tinsertInfo(request);

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
	    
		
		//老師查看當天所有學生表單
		@GetMapping("/teacher/findbydate")
		public ResponseEntity<List<Info>> findbydate(String  date){
				//	System.out.println("進api");
					return ResponseEntity.ok().body(Tservice.findinfobydate(date));
		}
		
		
		//老師查看當天所有學生表單
		@GetMapping("/teacher/{id}")
		public ResponseEntity<List<Info>> tfindbysid(@PathVariable("id")String  id){
			return ResponseEntity.ok().body(Tservice.findinfo(id));
		}
		
		
		//學生查看歷史表單
		@GetMapping("/student/{id}/date")
		public ResponseEntity<Info> findbystudentidnddate(@PathVariable("id")String  id,String date){
					
					return ResponseEntity.ok().body(Tservice.findinfobyidanddate(id,date));
		}
		
		//學生查看歷史表單
		@GetMapping("/student/{id}")
		public ResponseEntity<List<Info>> findbystudentid(@PathVariable("id")String  id){
			
			return ResponseEntity.ok().body(Tservice.findinfo(id));
		}
		//查看是否登入了
		@GetMapping("/test")
		public String displayHomePage(Model model, Principal user) {
			 String name ="";
		    if (user != null) {
		         name = user.getName();
		        System.out.println(name);
		    }else {
		    	name = null;
		    }
		    
		   return name;
		}
		
		//查看今日是否填寫表單
		@GetMapping("/checktodayinfo")
		public String checktodayinfo(String date ,String number) {
					 
				    
				   return Tservice.checktodayinfoservice(date,number);
		}
		
		
		
		@GetMapping("/checkrole")
		public String printWelcome(ModelMap model, Authentication authentication) {
			
			if(authentication==null)
				return "尚未登入";
			else if(authentication.getAuthorities().toString().equals("[ROLE_TEACHER]"))
				return "teacher";
			else if(authentication.getAuthorities().toString().equals("[ROLE_STUDENT]"))
				return "student";
			
			return "尚未登入";
		}
		
		
}
