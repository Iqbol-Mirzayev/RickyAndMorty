import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_and_morty/core/usecases/usecase.dart';
import 'package:ricky_and_morty/future/domain/repositories/person_repository.dart';
import 'package:meta/meta.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class SearchPerson extends Usecase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;
  SearchPerson(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
