import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/widgets/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? tappedIndex;
  String? tappedCategory;

  final categorys = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    tappedCategory = 'Business';
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

  @override
  Widget build(BuildContext context) {
    Widget _builActiveCategory() {
      // return Row(
      //   children: categorys.map(
      //     (ctg) {
      //       return GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             tappedCategory = ctg;
      //           });
      //         },
      //         child: CategoryItemWidget(
      //           title: ctg,
      //           isSelected: ctg == tappedCategory,
      //         ),
      //       );
      //     },
      //   ).toList(),
      // );

      // return Wrap(
      //   runSpacing: 5.0,
      //   spacing: 5.0,
      //   children: categorys.map(
      //     (ctg) {
      //       return GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             tappedCategory = ctg;
      //           });
      //         },
      //         child: CategoryItemWidget(
      //           title: ctg,
      //           isSelected: ctg == tappedCategory,
      //         ),
      //       );
      //     },
      //   ).toList(),
      // );

      return const SizedBox();
    }

    Widget _buildBody() {
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

    Widget _buildCategories() {
      return Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: categorys.map(
                  (ctg) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tappedCategory = ctg;
                        });
                      },
                      child: CategoryItemWidget(
                        title: ctg,
                        isSelected: ctg == tappedCategory,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategories(),
          Expanded(child: _buildBody()),
        ],
      ),
      // body: _buildCategories(),
    );
  }
}
