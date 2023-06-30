import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/core/error/failure.dart';
import 'package:ricky_and_morty/future/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);


  
}
  