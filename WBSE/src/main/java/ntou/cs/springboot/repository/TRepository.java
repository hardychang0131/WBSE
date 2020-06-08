package ntou.cs.springboot.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import ntou.cs.springboot.entity.Info;

@Repository
public interface TRepository extends MongoRepository<Info, String>{

}
