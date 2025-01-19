import 'package:awesome_portfolio/providers/current_state.dart';
import 'package:awesome_portfolio/providers/theme_provider.dart';
import 'package:awesome_portfolio/screen/homescreen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // يجب أن يكون قبل أي كود آخر
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CurrentState()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // استخدام الثيم من ThemeProvider
            home: child,
          );
        },
        child: const HomePage(),
      ),
    );
  }
}
