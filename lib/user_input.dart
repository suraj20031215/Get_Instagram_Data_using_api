import 'package:app/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInput extends StatefulWidget {
  const UserInput({super.key});


  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.instagram,size: 200,color: Colors.white,),
          SizedBox(
            height: 10,
          ),
          TextField(
        controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 4,color: Colors.white),borderRadius: BorderRadius.circular(12)),filled: true,
              fillColor: Colors.grey[100],
              hintText: 'Enter Your Username'
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => InstagramApi(usern: username.text ))
                 );

            }, child: Text('Search',
              style: TextStyle(color: Colors.white),
            )
            ),
          )
        ],
      ),
    ),);
  }
}
