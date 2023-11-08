import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteArticleError) {
          return const Center(
            child: Icon(Icons.refresh_rounded),
          );
        }

        if (state is RemoteArticleLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              // print(state.result[index].title);
              return ArticleWidget(
                article: state.result[index],
                onArticlePressed: (article) => {},
              );
            },
            itemCount: state.result.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
