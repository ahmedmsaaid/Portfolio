import 'package:awesome_portfolio/apps/data/apps_cubit/apps_cubit.dart';
import 'package:awesome_portfolio/apps/screeens/file_detail_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppsScreen extends StatelessWidget {
  final String repoUrl;

  AppsScreen({required this.repoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        // end: Alignment(0, -0.4),
        colors: [Colors.blue, Colors.black45],
      )),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (_) => AppsCubit()..loadFiles(repoUrl),
          child: BlocBuilder<AppsCubit, AppsState>(
            builder: (context, state) {
              if (state is FileGridLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FileGridLoaded) {
                final files = state.files;
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30)),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return GestureDetector(
                          onTap: () {
                            // عند الضغط على العنصر، ننتقل إلى صفحة التفاصيل
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FileDetailPage(file: file),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FutureBuilder<String>(
                                future: checkImageUrl(file),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Image.network(
                                        "https://example.com/default_image.jpeg"); // صورة افتراضية
                                  } else {
                                    return AppWidget(
                                      imageUrl: snapshot.data ?? '',
                                      appName: file,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is FileGridError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Center(child: Text('No files found.'));
            },
          ),
        ),
      ),
    );
  }

  Future<String> checkImageUrl(String file) async {
    String uri =
        "https://raw.githubusercontent.com/ahmedmsaaid/assets/main/$file/0.png"; // تعديل ليتناسب مع اسم الصورة
    try {
      final response = await Dio().head(uri);

      // تحقق مما إذا كان الرابط يعمل
      if (response.statusCode == 200) {
        return uri; // الرابط شغال
      } else {
        throw Exception('رابط الصورة غير شغال');
      }
    } catch (e) {
      final link = uri.replaceAll("png", "jpeg");
      // في حالة وجود خطأ، نعيد رابط للصورة الافتراضية
      return link; // تغيير هذا إلى رابط صورة افتراضية أو تغييره إلى jpeg
    }
  }
}

class AppWidget extends StatelessWidget {
  final String imageUrl;
  final String appName;

  AppWidget({required this.imageUrl, required this.appName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.contain,
              height: 50,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            appName,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
