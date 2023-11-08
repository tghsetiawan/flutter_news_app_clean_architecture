part of 'local_article_bloc.dart';

sealed class LocalArticleState extends Equatable {
  const LocalArticleState();
  
  @override
  List<Object> get props => [];
}

final class LocalArticleInitial extends LocalArticleState {}
