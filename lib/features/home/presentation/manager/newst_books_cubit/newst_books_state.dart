part of 'newst_books_cubit.dart';

sealed class NewstBooksState extends Equatable {
  const NewstBooksState();

  @override
  List<Object> get props => [];
}

class NewstBooksInitial extends NewstBooksState {}

class NewstBooksLoading extends NewstBooksState {}

class NewstBooksFailure extends NewstBooksState {
  final String errorMessage;
  const NewstBooksFailure(this.errorMessage);
}

class NewstBooksSuccess extends NewstBooksState {
  final List<BookModel> books;
  const NewstBooksSuccess(this.books);
}
