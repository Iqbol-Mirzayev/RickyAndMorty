import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_and_morty/core/error/failure.dart';
import 'package:ricky_and_morty/future/domain/entities/person_entity.dart';

import '../../../../domain/usecases/search_person.dart';

part 'search_event.dart';
part 'search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    } else {}
  }

  _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'UnExpected Error';
    }
  }
}
