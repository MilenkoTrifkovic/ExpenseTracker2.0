import 'package:expense_tracker_2/services/cloud_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
   ThirdScreen({super.key});
  
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  // late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    // futureAlbum = 
    CloudFunction.fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child:const  Text("Passed"),
          // child: FutureBuilder<Album>(
          //   future: futureAlbum,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Text(snapshot.data!.title);
          //     } else if (snapshot.hasError) {
          //       return Text('${snapshot.error}');
          //     }

          //     // By default, show a loading spinner.
          //     return const CircularProgressIndicator();
          //   },
          ),
        );
    
  }
}