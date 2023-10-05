import 'package:blogs_task/bloc/home_bloc.dart';
import 'package:blogs_task/bloc/internet_bloc/internet_bloc.dart';
import 'package:blogs_task/models/blog_data.dart';
import 'package:blogs_task/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogsAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogs - SubSpace Task',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
          ),
          BlocProvider<InternetBloc>(
            create: (BuildContext context) => InternetBloc(),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
