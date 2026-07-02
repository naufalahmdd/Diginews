import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/news_cubit.dart';
import '../bloc/news_state.dart';
import '../widgets/article_tile.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DigiNews'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<NewsCubit>().loadNews(),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading || state is NewsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NewsError) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Icon(Icons.wifi_off, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  Center(child: Text(state.message, textAlign: TextAlign.center)),
                ],
              );
            }
            final success = state as NewsSuccess;
            return ListView.separated(
              itemCount: success.articles.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) => ArticleTile(article: success.articles[i]),
            );
          },
        ),
      ),
    );
  }
}