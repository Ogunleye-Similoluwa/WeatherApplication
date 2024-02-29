import 'package:flutter/material.dart';
import 'package:weathercommuteapplication/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:weathercommuteapplication/state_management/state_manager.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
      create:(_) => StateManager(),
      child:Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "Weather Application",
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Raleway',
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
        ),
        routerConfig: RouteConfig.router,

    );
  }
}

