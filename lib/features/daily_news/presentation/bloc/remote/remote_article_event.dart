part of 'remote_article_bloc.dart';

abstract class RemoteArticleEvent extends Equatable {
  const RemoteArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchArticle extends RemoteArticleEvent {
  const FetchArticle();

  @override
  List<Object> get props => [];
}
