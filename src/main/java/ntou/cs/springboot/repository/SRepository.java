package ntou.cs.springboot.repository;

import java.util.List;
import java.util.stream.Stream;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import ntou.cs.springboot.entity.Student;

@Repository
public interface SRepository extends MongoRepository<Student, String>{

	
	
}
