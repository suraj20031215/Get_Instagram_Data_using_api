import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class InstagramApi extends StatefulWidget {
  final String usern;

  InstagramApi({required this.usern});

  @override
  State<InstagramApi> createState() => _InstagramApiState();
}

class _InstagramApiState extends State<InstagramApi> {


  Map<String, dynamic> instagramData = {};
  bool loaded = false;

  Future<void> fetchData() async {
    try {
      Map<String, String> headers = {
        'X-RapidAPI-Key': '7df9eada5bmsh9968c5ca05956e4p1eb0fcjsn0ce85126a06a',
      };

      http.Response response = await http.get(
        Uri.parse('https://instagram130.p.rapidapi.com/account-info?username=${widget.usern}'),
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
      print('Error ');
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
          title: Text(instagramData['username']),
        ),
        body: !loaded
            ? const Center(child: CircularProgressIndicator())
            :Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      height: 100,
                      child: CircleAvatar(backgroundImage: NetworkImage(instagramData['profile_pic_url']))),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(instagramData['edge_owner_to_timeline_media']['count'].toString(),textScaleFactor: 1.4,)),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(instagramData['edge_followed_by']['count'].toString(),textScaleFactor: 1.4)),
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(instagramData['edge_follow']['count'].toString(),textScaleFactor: 1.4)),


                  ]),
              Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 5),
                child: Text(instagramData['username'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              ),
              Text(instagramData['biography']),
              const Divider(),
            ],
          ),
        )
    );
  }
}