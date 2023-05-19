
// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'model.dart';

// ignore: camel_case_types, must_be_immutable
class Second_Screen extends StatelessWidget {
  Second_Screen({Key? key, required this.index}) : super(key: key);
  final int index;

  List<Search> samplePosts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Column(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.network('${samplePosts[index].poster}'),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children: [
                                          Flexible(
                                            child: Text(samplePosts[index].title!
                                              ,style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                          ),

                                    IconButton(onPressed: (){}, icon: const Icon(Icons.notifications), color: Colors.white,),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.share), color: Colors.white,),

                                  ],
                      ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Released in ${samplePosts[index].year!}",
                                        style: const TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Imdb Rating: ${samplePosts[index].imdbID!}", style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 14),),
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("The Type of it is : ${samplePosts[index].type!}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),),
                                    )
                      ]
                                );
                              } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                ),
              ]
          ),
        ),
      )
    );
  }

  Future<List<Search>>getData() async {
    final response = await http.get(Uri.parse('https://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Iterable list = data["Search"];
      samplePosts = list.map((e) => Search.fromJson(e)).toList();
      return samplePosts;
    } else {
      return samplePosts;
    }
  }
}
