import "dart:convert";
import 'teamDetail.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "login.dart";
import 'package:brl_task4/models/appbar.dart';

class dashb_mem extends StatefulWidget {
  const dashb_mem({super.key});

  @override
  State<dashb_mem> createState() => dashb_memState();
}

String? name;

class dashb_memState extends State<dashb_mem> {
  Future<void>? _futureData;
  void initState() {
    super.initState();
    _futureData = showTeamAPI();
  }

  List<dynamic>? teamsData;
  List<String>? teamNames;
  //String  name ;
  Future<void> showTeamAPI() async {
    dynamic storedValue = await secureStorage.readSecureData(key);

    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/showTeams';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': storedValue,
      },
    );

    if (response.statusCode == 200) {
      teamsData = jsonDecode(response.body)['teams'];
      name = jsonDecode(response.body)['email'];
      teamNames = teamsData!
          .map<String>((team) => team['teamName'].toString())
          .toList();
      name = jsonDecode(response.body)['email'];
    } else {
      print(' ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
    // print(teamNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(

      //   onPressed: (){
      //     // Navigator.pushNamed(context, ChatScreen(name!) as String);
      //      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(name!)));
      //   },
      //   child: Icon(Icons.chat),
      // ),
      appBar: MyAppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.purple.shade100,
                child: Center(
                    child: Text(
                  "TEAMS",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ))),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<void>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (teamNames == null) {
                        return Text("No team to show");
                      }
                      return ListView.builder(
                        itemCount: teamNames!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              width:
                                  MediaQuery.of(context).size.width / (4 / 3),
                              height: MediaQuery.of(context).size.height / 10,
                              color: Colors.grey.shade50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(
                                      color: Colors.purple, width: 1),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => t_detail(
                                              team: teamsData![index])));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: 2,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      teamNames![index].toUpperCase(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
