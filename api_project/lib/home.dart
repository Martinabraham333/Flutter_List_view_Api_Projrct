import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Album>> fetchAlbums() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<Album> albums =
        data.map((albumJson) => Album.fromJson(albumJson)).toList();
    return albums;
  } else {
    throw Exception('Failed to load albums');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class ApiHome extends StatefulWidget {
  const ApiHome({Key? key});

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Album> albums = snapshot.data!;

              return ListView.builder(

                
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  Album album = albums[index];
                return Card(
                  color: Color.fromARGB(255, 59, 255, 183),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title: ${album.title}",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 11, 7, 255)),),
          Text("User ID: ${album.userId}"),
          Text("Album ID: ${album.id}"),
        ],
      ),
    ),
  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';


// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
   
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
    
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// class apihome extends StatefulWidget {
//   const apihome({super.key});

//   @override
//   State<apihome> createState() => _apihomeState();
// }

// class _apihomeState extends State<apihome> {

//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

// appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//  body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 //return Text(snapshot.data!.title);
//                 return Container(

//                   width: 300,
//                   height: 150,
//                   child:Card(
                    
                    
//                    child:Column(
                    
//                     children: [
//                       Padding(padding: EdgeInsets.all(10),
//                       child:Text("Title :${snapshot.data!.title}")),
//                       Padding(padding: EdgeInsets.all(10),
//                       child:Text("User ID :${snapshot.data!.userId}"),),

//                       Padding(padding: EdgeInsets.all(10),
//                       child:  Text("Album ID :${snapshot.data!.id}"),)
                    
                    
                    
//                   ],))
                 
                  
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

             
//               return const CircularProgressIndicator();
//             },
//           )
//  )

//     );
//   }
// }