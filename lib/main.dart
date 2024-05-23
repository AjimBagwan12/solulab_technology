import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solulab_technology/api/flower_api.dart';
import 'package:solulab_technology/screens/details_screen.dart';
import 'package:solulab_technology/screens/flower_list_screen.dart';
import 'package:solulab_technology/screens/splash_screen.dart';

void main() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://mocki.io/v1/',
  ));
  final flowerApi = FlowerApi(dio);

  runApp(MyApp(flowerApi: flowerApi));
}

class MyApp extends StatelessWidget {
  final FlowerApi flowerApi;
  const MyApp({Key? key, required this.flowerApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // showSemanticsDebugger: false,

      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(flowerApi: flowerApi,),
        '/flowers': (context) => FlowerListScreen(api: flowerApi),
        'flower_details': (context) {
          final Flower flower = ModalRoute.of(context)!.settings.arguments as Flower;
          return FlowerDetailsScreen(flower: flower);
        },
      },
    );
  }
}
