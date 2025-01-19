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
      decoration: BoxDecoration(
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
                return Center(child: CircularProgressIndicator());
              } else if (state is FileGridLoaded) {
                final files = state.files;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
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
                            builder: (context) => FileDetailPage(file: file),
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
                                return Center(
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.black,
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.amber),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withAlpha(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.amber),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Colors.white.withAlpha(100),
            ),
            child: Center(
              child: Text(
                appName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
