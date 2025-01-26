import 'package:awesome_portfolio/apps/data/apps_cubit/apps_cubit.dart';
import 'package:awesome_portfolio/apps/screeens/apps_screen.dart';
import 'package:awesome_portfolio/apps/screeens/file_detail_page.dart';
import 'package:awesome_portfolio/consts/dialog.dart';
import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:device_frame/device_frame.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../consts/data.dart';
import '../../providers/current_state.dart';

class PhoneHomeScreen extends StatelessWidget {
  const PhoneHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentState currentState =
        Provider.of<CurrentState>(context, listen: false);
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
      child: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            children: List.generate(
                apps.length,
                (index) => Container(
                      margin: const EdgeInsets.only(
                          right: 10, top: 10, bottom: 20, left: 10),
                      // width: 70,
                      child: Column(
                        children: [
                          CustomButton(
                            margin: const EdgeInsets.only(bottom: 5),
                            borderRadius: currentState.currentDevice ==
                                    Devices.ios.iPhone13
                                ? 8
                                : 100,
                            onPressed: () {
                              if (apps[index].link != null) {
                                // open the url in the webpage
                                currentState.launchInBrowser(
                                  apps[index].link!,
                                );
                              } else if (apps[index].screen != null) {
                                currentState.changePhoneScreen(
                                    apps[index].screen!, false,
                                    titlee: apps[index].title);
                              } else if (apps[index].title == "Apps") {
                                Alerts.showMassage(
                                    context,
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100), // نصف الدائرة
                                      ),
                                      child: Center(
                                        child: Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: BlocProvider(
                                            create: (_) => AppsCubit()
                                              ..loadFiles(
                                                  "https://api.github.com/repos/ahmedmsaaid/assets"),
                                            child: BlocBuilder<AppsCubit,
                                                AppsState>(
                                              builder: (context, state) {
                                                if (state is FileGridLoading) {
                                                  return Center(
                                                      child: Lottie.asset(
                                                          "assets/lottie/loading.json"));
                                                } else if (state
                                                    is FileGridLoaded) {
                                                  // تصفية الملفات لإزالة "Zicons"
                                                  final files = state.files
                                                      .where((file) =>
                                                          file != "Zicons")
                                                      .toList();

                                                  return GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 1,
                                                      mainAxisSpacing: 1,
                                                    ),
                                                    itemCount: files.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final file = files[index];

                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          currentState
                                                              .changePhoneScreen(
                                                            FileDetailPage(
                                                                file: file),
                                                            false,
                                                            titlee: file,
                                                          );
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            FutureBuilder<
                                                                String>(
                                                              future:
                                                                  checkImageUrl(
                                                                      file),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Center(
                                                                      child:
                                                                          Container());
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Image
                                                                      .network(
                                                                          "https://example.com/default_image.jpeg"); // صورة افتراضية
                                                                } else {
                                                                  return AppWidget(
                                                                    imageUrl:
                                                                        snapshot.data ??
                                                                            '',
                                                                    appName:
                                                                        file,
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else if (state
                                                    is FileGridError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${state.message}'));
                                                }
                                                return Center(
                                                    child: Text(
                                                        'No files found.'));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }
                            },
                            width: 45,
                            height: 45,
                            asset: apps[index].assetPath != null
                                ? ButtonAsset(apps[index].assetPath!,
                                    width: 25, height: 25)
                                : null,
                            backgroundColor: apps[index].color,
                            child: apps[index].assetPath == null
                                ? Center(
                                    child: Icon(
                                      apps[index].icon,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                apps[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.openSans(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  Future<String> checkImageUrl(String file) async {
    String uri =
        "https://raw.githubusercontent.com/ahmedmsaaid/assets/main/Zicons/$file.png"; // تعديل ليتناسب مع اسم الصورة
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
