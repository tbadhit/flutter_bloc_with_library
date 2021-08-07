import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // WAJIB DI BUNGKUS DENGAN BlocProvider() agar ColorBloc..
      // bisa di digunakan di seluruh kelas turunan BlocProvider dalam kasus ini MainPage()
      // (BlocProvider akan bertanggung jawab juga dalam menangani masalah dispose ketika stream udh ga di pake)
      home: BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(Colors.amber), child: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Perintah untuk mengambil objek BLoC dari Bloc Provider di Routenya
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter BLoC"),
        ),
        body: Center(
          // Untuk menghubungkan animated dengan stream dari blocnya menggunakan widget (BlocBuilder)
          // (BlocBuilder) Fungsinya membuild widget ketika ada update dari stream
          child: BlocBuilder<ColorBloc, Color>(
            builder: (context, currentColor) {
              return AnimatedContainer(
                width: 100,
                height: 100,
                color: currentColor,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                bloc.add(ColorEvent.to_amber);
              },
              backgroundColor: Colors.amber,
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.add(ColorEvent.to_light_blue);
              },
              backgroundColor: Colors.lightBlue,
            )
          ],
        ));
  }
}
