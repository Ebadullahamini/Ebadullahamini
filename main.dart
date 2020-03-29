import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



  Future<Album> fetchAlbum() async{
    final response = await http.get(
      Uri.encodeFull("http://192.168.43.106:8080/customers/"),
      headers: {
        "Accept": "application/json"
      }
    );

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load Album');
    }
  }

  class  Album {
    final int id;
    final String email;
    final String name;

    Album({this.id, this.email, this.name});

    factory Album.fromJson(Map<String, dynamic> json){
      return Album(
        id: json['id'],
        email: json['email'],
        name: json['name'],
      );
    }
  }

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}
class HomePageState extends State<HomePage> {


  // Map<String, dynamic> data;

  // Future<String> getData() async{
  //   var response = await http.get(
  //     Uri.encodeFull("http://192.168.43.106:3000/customers"),
  //     headers: {
  //       "Accept" : "application/json"
  //     }
  //   );

    // this.setState((){
    //   // data = jsonDecode(response.body);
    // });
    // setState(() {
      // data = jsonDecode(response.body);
    // });

    // print(data['name']);
    // debugPrint(response.body);

    // return "Success";
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   this.getData();
  // }


  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data.name);
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
