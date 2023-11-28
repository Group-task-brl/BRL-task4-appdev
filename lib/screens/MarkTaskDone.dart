import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "login.dart";

class doneTask extends StatefulWidget {
  const doneTask({super.key});

  @override
  State<doneTask> createState() => _doneTaskState();
}

class _doneTaskState extends State<doneTask> {

  Future<void> TaskDoneAPI() async {
    dynamic storedValue = await secureStorage.readSecureData(key);
    // print (storedValue);
    final String apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/taskDone';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization' :storedValue,
        // 'Content-Type': 'application/json'
      },

      body: ({
        "teamCode": TeamCodeController.text,
        "domainName": DomainController.text,
        "email": EmailController.text,
        "task": TaskController.text,
      }),
    );

    if (response.statusCode == 200) {
      // print('API Response: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Marked Task Done"),),);

    } else {
      print(' ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
  }

  TextEditingController EmailController =TextEditingController();
  TextEditingController DomainController =TextEditingController();
  TextEditingController TaskController =TextEditingController();
  TextEditingController TeamCodeController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.6, 0.8),
            end: Alignment(0.6, 0.21),
            colors: [Color(0xFF150218), Color(0xFF65386C)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 80,),

                  Text("Task Done",style:TextStyle(color: Colors.white,fontSize:40,fontWeight: FontWeight.w700),),
                  SizedBox(height: 30,),


                  Container(
                    width: 303,
                    height: 400,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.15000000596046448),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 48,
                            width: 270,
                            color: Colors.white,
                            child: TextFormField(
                              controller: TeamCodeController,
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.groups_outlined),
                                // prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Team Code",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                                // suffixIcon: Icon(Icons.visibility),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 48,
                            width: 265,
                            color: Colors.white,
                            child: TextFormField(
                              controller: DomainController,
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.domain),
                                // prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Domain",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                                // suffixIcon: Icon(Icons.visibility),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),SizedBox(height: 25,),
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 48,
                            width: 265,
                            color: Colors.white,
                            child: TextFormField(
                              controller: EmailController,
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.email),
                                // prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Email",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                                // suffixIcon: Icon(Icons.visibility),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 48,
                            width: 265,
                            color: Colors.white,
                            child: TextFormField(
                              controller: TaskController,
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.add_box_rounded),
                                // prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Task",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                                // suffixIcon: Icon(Icons.visibility),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35,),
                        ElevatedButton(onPressed: (){
                          TaskDoneAPI();
                          // joinTeamAPI();
                        },
                          style:ElevatedButton.styleFrom(
                            backgroundColor:Color.fromARGB(255, 225, 169, 229),
                            // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),

                          ),
                          child:Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Add Task"),
                              SizedBox(width:5),
                              IconButton(onPressed:(){},icon:Icon(Icons.arrow_circle_right_outlined)),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
