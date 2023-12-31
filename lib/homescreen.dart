import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class NewsApi extends StatefulWidget {
  const NewsApi({super.key});


  @override
  State<NewsApi> createState() => _NewsApiState();
}

class _NewsApiState extends State<NewsApi> {


  Map<String, dynamic> instagramData = {};
  bool loaded = false;

  Future<void> fetchData() async {
    try {
      Map<String, String> headers = {
        'X-RapidAPI-Key': '7df9eada5bmsh9968c5ca05956e4p1eb0fcjsn0ce85126a06a',
      };

      http.Response response = await http.get(
        Uri.parse('https://instagram130.p.rapidapi.com/account-info?username=_ishika_bharti'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        setState(() {
          instagramData = json.decode(response.body);
          loaded = true;
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Theme.of(context).hoverColor,
        appBar: AppBar(
          title: Text('Instagram'),
        ),
        body: !loaded
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(instagramData['profile_pic_url_hd']),
              title: Text(instagramData['username'] ?? ''),
              subtitle: Text(instagramData['biography'] ?? ''),
              trailing: Text(instagramData['edge_follow']['count'].toString(),textScaleFactor: 1.4,),
            );
          },
          itemCount: 1, // Since it's one user data
        ),
    );
  }
}
