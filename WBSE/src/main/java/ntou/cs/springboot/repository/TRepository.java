package ntou.cs.springboot.repository;

import java.util.List;
import java.util.stream.Stream;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import ntou.cs.springboot.entity.Info;

@Repository
public interface TRepository extends MongoRepository<Info, String>{

	@Query("{ 'number' : ?0 }")
	List<Info> findbyid(String number);
	
//	@Query("{ 'number' : ?0,'date' : ?0 }")
//	Stream<Info> findbyidforone(String number ,String date);
	
	@Query("{$and: [ { 'number':  ?0  }, { 'date':  ?1  } ]}")
	Stream<Info> findbyidforone(String number ,String date);
	
	
}
