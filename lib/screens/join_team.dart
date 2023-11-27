import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "../models/join_model.dart";
import "../screens/login.dart";
import '../models/storeToken.dart';
class join_team extends StatefulWidget {
  const join_team({super.key});

  @override
  State<join_team> createState() => _join_teamState();
}

class _join_teamState extends State<join_team> {

  Future<void> joinTeamAPI() async {
    dynamic storedValue = await secureStorage.readSecureData(key);

    final String apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/joinTeam';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization' :storedValue,
      },
      body: joinTeamToJson(
          JoinTeam(
            teamCode: TeamNameController.text,
            domainName: DomainController.text,
          ),
      ),
    );

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
    } else {
      print('Failed to join the team. Status Code: ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
  }
  TextEditingController TeamNameController =TextEditingController();
  TextEditingController DomainController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                      child: Container(
                        height: 45,
                        width: 310,
                        color: Colors.grey,
                        child: TextFormField(
                          controller: TeamNameController,
                          decoration: InputDecoration(
                            // prefixIcon:Icon(Icons.looks),
                            prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                            hintText: "Team Code",
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                            suffixIcon: Icon(Icons.visibility),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                      child: Container(
                        height: 45,
                        width: 310,
                        color: Colors.grey,
                        child: TextFormField(
                          controller: DomainController,
                          decoration: InputDecoration(
                            // prefixIcon:Icon(Icons.looks),
                            prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                            hintText: "Domain",
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                            suffixIcon: Icon(Icons.visibility),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: (){
                      joinTeamAPI();
                    },

                        child:Text("Join"),),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
