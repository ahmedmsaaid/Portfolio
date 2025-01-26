import 'package:awesome_portfolio/apps/data/apps_cubit/apps_cubit.dart';
import 'package:awesome_portfolio/apps/screeens/file_detail_page.dart';
import 'package:awesome_portfolio/providers/current_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AppsScreen extends StatelessWidget {
  final String repoUrl;

  AppsScreen({required this.repoUrl});

  @override
  Widget build(BuildContext context) {
    CurrentState currentState =
        Provider.of<CurrentState>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [Colors.blue, Colors.black45],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (_) => AppsCubit()..loadFiles(repoUrl),
          child: BlocBuilder<AppsCubit, AppsState>(
            builder: (context, state) {
              if (state is FileGridLoading) {
                return Center(
                    child: Lottie.asset("assets/lottie/loading.json"));
              } else if (state is FileGridLoaded) {
                final files = state.files
                    .where((file) => file != "zicons")
                    .toList(); // تصفية العناصر

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
                        currentState.changePhoneScreen(
                          FileDetailPage(file: file),
                          false,
                          titlee: file,
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

  // Future<String> checkImageUrl(String file) async {
  //   String uri =
  //       "https://raw.githubusercontent.com/ahmedmsaaid/assets/main/icons/$file.png"; // تعديل ليتناسب مع اسم الصورة
  //   try {
  //     final response = await Dio().head(uri);
  //
  //     // تحقق مما إذا كان الرابط يعمل
  //     if (response.statusCode == 200) {
  //       return uri; // الرابط شغال
  //     } else {
  //       throw Exception('رابط الصورة غير شغال');
  //     }
  //   } catch (e) {
  //     final link = uri.replaceAll("png", "jpeg");
  //     // في حالة وجود خطأ، نعيد رابط للصورة الافتراضية
  //     return link; // تغيير هذا إلى رابط صورة افتراضية أو تغييره إلى jpeg
  //   }
  // }
}

class AppWidget extends StatelessWidget {
  final String imageUrl;
  final String appName;

  AppWidget({required this.imageUrl, required this.appName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: 30,
                  height: 30,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Text(
            appName,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
