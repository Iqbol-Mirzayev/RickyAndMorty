import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/core/error/failure.dart';
import 'package:ricky_and_morty/future/domain/entities/person_entity.dart';
import 'package:ricky_and_morty/future/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository  {
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) {
    // TODO: implement getAllPersons
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) {
    // TODO: implement searchPerson
    throw UnimplementedError();
  }

}