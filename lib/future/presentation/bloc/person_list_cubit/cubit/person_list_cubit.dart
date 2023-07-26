import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_and_morty/future/domain/usecases/get_all_persons.dart';

import '../../../../../core/error/failure.dart';
import '../../../../domain/entities/person_entity.dart';

part 'person_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));
    failureOrPerson
        .fold((error) => PersonError(message: _mapFailureToMessage(error)),
            (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'UnExpected Error';
    }
  }
}  
