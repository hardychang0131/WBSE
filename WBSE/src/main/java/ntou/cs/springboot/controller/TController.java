package ntou.cs.springboot.controller;

import java.net.URI;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.bind.annotation.ModelAttribute;
import ntou.cs.springboot.entity.Info;
import ntou.cs.springboot.service.TService;
@RestController
@RequestMapping(value = "/thermometer")
public class TController {
	@Autowired
	private TService Tservice;
	
	 @PostMapping
	    public ResponseEntity<Info> createNote(@ModelAttribute Info request) {
		 
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
	
	
	
}
