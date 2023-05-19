import 'dart:convert';
import 'dart:io';
import 'package:api_future/second_screen.dart';
import 'package:flutter/gestures.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:api_future/model.dart';
import 'package:flutter/material.dart';

class MovieMainScreen extends StatefulWidget {
  const MovieMainScreen({Key? key}) : super(key: key);

  @override
  State<MovieMainScreen> createState() => _MovieMainScreenState();
}

class _MovieMainScreenState extends State<MovieMainScreen> {

  List<Search> samplePosts = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 35,
          backgroundImage: NetworkImage('https://deadline.com/wp-content/uploads/2022/08/Netflix_Symbol_logo.jpg?w=1024'),
        ),
        title: const Text("NETFLIX", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 30),),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 30, color: Colors.black,)),
          const SizedBox(width: 8,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, size: 30, color: Colors.black,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            const Text("Popular on Netflix", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 20,),
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: samplePosts.length,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Second_Screen(index: index)),
                                    );
                            },
                                  child: SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: Image.network('${samplePosts[index].poster}'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(samplePosts[index].title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                ),
                                
                              ],
                            );
                          }

                      ),
                    ),
                  );
                } else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
    ]
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