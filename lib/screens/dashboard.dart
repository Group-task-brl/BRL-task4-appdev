
import "dart:convert";

import "package:brl_task4/Utils/Routes.dart";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "login.dart";
import 'package:brl_task4/models/appbar.dart';

class dashb_mem extends StatefulWidget {
  const dashb_mem({super.key});

  @override
  State<dashb_mem> createState() => dashb_memState();
}

class dashb_memState extends State<dashb_mem> {
  Future<void>? _futureData;
  void initState() {
    super.initState();
    _futureData =showTeamAPI();
  }
  List<String>? teamNames;
  Future<void> showTeamAPI() async {
    dynamic storedValue = await secureStorage.readSecureData(key);

    final String apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/showTeams';
    final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization' :storedValue,
        },);
    List<dynamic> teamsData = jsonDecode(response.body)['teams'];
    teamNames = teamsData.map<String>((team) => team['teamName'].toString()).toList();
    // Map<String, dynamic> jsonResponse = jsonDecode(response);
    //
    // teamNames = jsonResponse['teams']
    //     .map<String>((team) => team['teamName'].toString())
    //     .toList();

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
    } else {
      print('Failed to join the team. Status Code: ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
    // print(teamNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(),
      body: Container(
        child: Column(
          children:[
            Text("Active Team"),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                child:FutureBuilder<void>(
                  future: _futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                          child: CircularProgressIndicator(
                          color:Colors.white,
                          ),
                      );
                    } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                     } else {
                        if(teamNames==null){
                          return Text("No team to show");
                        }
                      return ListView.builder(
                       itemCount:teamNames!.length,
                        itemBuilder: (context,index){
                            return ListTile(
                              title: ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context,MyRoutes.tdetailRoutes);
                                },
                                child: Text(teamNames![index]),
                              ),
                            );
                       },);
                      }
                  },
                ),
              ),
            ),


          Row(
            children: [
              Container(
              )
            ],
          ),
          ]
        ),
      ),
    );
  }
}
