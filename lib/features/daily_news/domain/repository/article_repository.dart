import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_clean_architecture/core/resources/failure.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  //API Methods
  Future<Either<Failure, List<ArticleEntity>>> getNews();

  //Database Methods
}
