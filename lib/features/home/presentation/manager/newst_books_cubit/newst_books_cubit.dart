import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/home/data/models/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'newst_books_state.dart';

class NewstBooksCubit extends Cubit<NewstBooksState> {
  NewstBooksCubit(this.homeRepo) : super(NewstBooksInitial());

  final HomeRepo homeRepo;
  Future<void> featchNewsdBooks() async {
    emit(NewstBooksLoading());
    var result = await homeRepo.fetchNewsedBooks();
    result.fold((failure) {
      emit(NewstBooksFailure(failure.toString()));
    }, (books) {
      emit(NewstBooksSuccess(books));
    });
  }
}
