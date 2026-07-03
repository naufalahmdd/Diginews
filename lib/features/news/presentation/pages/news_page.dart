import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart'; 
import '../bloc/news_state.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsBloc>()..add(FetchTopHeadlines()),
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsSuccess) {
              final articles = state.articles;

              if (articles.isEmpty) {
                return const Center(child: Text('Tidak ada berita ditemukan.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ), // PERBAIKAN: Menggunakan EdgeInsets.only
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.urlToImage.isNotEmpty)
                          Image.network(
                            article.urlToImage,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(height: 10),
                          ),
                        ListTile(
                          title: Text(
                            article.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: 6.0,
                            ), // PERBAIKAN: Menggunakan EdgeInsets.only
                            child: Text(
                              article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Oleh: ${article.author}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign
                          .center, // PERBAIKAN: Menggunakan TextAlign.center
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // PERBAIKAN: Menggunakan onPressed, bukan onTap
                        context.read<NewsBloc>().add(FetchTopHeadlines());
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
