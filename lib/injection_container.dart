import 'package:flutter_news_app_clean_architecture/features/daily_news/data/data_sources/local/db/database_helper.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // External
  locator.registerLazySingleton(() => http.Client());

  // Bloc
  locator
      .registerFactory(() => RemoteArticleBloc(getArticleUseCase: locator()));

  // Use Case
  locator.registerLazySingleton(() => GetArticleUseCase(locator()));

  // Repository
  locator.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(newsRemoteDataSource: locator()));

  // Data Source
  locator.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: locator()));
}
