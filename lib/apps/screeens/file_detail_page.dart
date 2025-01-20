import 'package:awesome_portfolio/apps/data/apps_cubit/apps_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileDetailPage extends StatelessWidget {
  final String file;

  FileDetailPage({required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file),
      ),
      body: BlocProvider(
        create: (_) => AppsCubit()
          ..loadFileImages(
              "https://api.github.com/repos/ahmedmsaaid/assets/contents$file"),
        child: BlocBuilder<AppsCubit, AppsState>(
          builder: (context, state) {
            if (state is FileImagesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FileImagesLoaded) {
              final images = state.images;
              return ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(images[index]);
                },
              );
            } else if (state is FileImagesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Center(child: Text('No images found.'));
          },
        ),
      ),
    );
  }
}
