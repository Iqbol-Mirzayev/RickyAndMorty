import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_and_morty/core/usecases/usecase.dart';
import 'package:ricky_and_morty/future/domain/repositories/person_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class GetAllPersons extends Usecase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;
  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;
  PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
