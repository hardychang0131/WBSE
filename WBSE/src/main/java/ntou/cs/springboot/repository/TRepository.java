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
	
	@Query("{$and: [ { 'number':  ?0  }, { 'date':  ?1  },{'status':'尚未審核'}]}")
	Stream<Info> findbyidforone(String number ,String date);
	
	@Query("{ $and: [{'date' : ?0},{'status':'尚未審核'}]}")
	List<Info> findbydate(String date);
	
	
	@Query("{ 'date' : ?0}")
	List<Info> findbytdate(String date);
}
