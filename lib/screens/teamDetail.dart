import "package:flutter/material.dart";
import 'package:table_calendar/table_calendar.dart';
class t_detail extends StatefulWidget {
   t_detail({required this.team});
  dynamic team;
  @override
  State<t_detail> createState() => _t_detailState();
}

class _t_detailState extends State<t_detail> {
  // List<dynamic> domains =team['domains'];
  dynamic teams;
  // String? domainName;
  String? leaderEmail;
  String? teamName;
  Future<void>? _futureData;
  void initState() {
    super.initState();
    // _futureData =api();
  }
  List<dynamic>? domains;
  Future<void> data (dynamic teams) async{
      setState(() {
        teamName=teams['teamName'];
        domains = teams['domains'];
        leaderEmail= teams['leaderEmail'];
        // domainName= domains['name'];
        // print(domains![0]['tasks']!.length);
      });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      teams = widget.team;
      data(teams);
    });
    return Scaffold(
      // drawer: Container(
      //   color: Colors.black,
      //   width: 190,
      //   child: Column(
      //     children:[
      //       SizedBox(height: 50,),
      //       Text('$teamName',style: TextStyle(color: Colors.white),),
      //       SizedBox(height: 50,),
      //       TextButton(child: Text("Add Task"),onPressed: (){},),
      //       SizedBox(height: 10,),
      //       TextButton(child: Text("Resources"),onPressed: (){},),
      //     ]
      //   ),
      // ),
        appBar:AppBar(title: Text("$teamName"),),
        body: SafeArea(
          child: Container(
            child: Column(
              children:[
                Text("Leader: "+leaderEmail!.substring(0,leaderEmail!.indexOf('@'))),
                SizedBox(height:10),


                SizedBox(height: 10,),
                FutureBuilder<void>(
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
                      return  Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount:domains!.length,
                            itemBuilder: (context,index) {
                              return ListTile(
                                title: Column(
                                  children: [
                                    Text("Domain: "+domains![index]['name']),
                                    SizedBox(height:10),
                                    Container(
                                      height: 100,
                                      child: ListView.builder(
                                          itemCount:domains![index]['members']!.length,
                                          itemBuilder: (context,index1) {
                                            return ListTile(
                                              title: Column(
                                                  children: [
                                                    Text("Members: "+domains![index]['members'][index1]),
                                                    SizedBox(height: 10,),
                                                  ]),);}),
                                    ),
                                    SizedBox(height: 10,),
                                    Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(60.0),
                                        1: FixedColumnWidth(80.0),
                                        2: FixedColumnWidth(85.0),
                                        3: FixedColumnWidth(80.0),
                                      },
                                      border: TableBorder(
                                          top: BorderSide(width: 2.0, color: Colors.black),
                                      left: BorderSide(width: 2.0, color: Colors.black),
                                      right: BorderSide(width: 2.0, color: Colors.black),
                                      bottom: BorderSide(width: 2.0, color: Colors.black)),
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(child: Text("Status")),
                                            ),
                                            TableCell(
                                              child: Center(child: Text('Member')),
                                            ),
                                            TableCell(
                                              child: Center(child: Text('Task')),
                                            ),
                                            TableCell(
                                              child: Center(child: Text('Deadline')),
                                            ),
                                          ],
                                        ),],),

                                    Container(
                                      height: 200,
                                      child: ListView.builder(
                                          itemCount:domains![index]['tasks']!.length,
                                          itemBuilder: (context,index2){
                                        return Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: ListTile(
                                              title:Table(
                                                columnWidths: {
                                                  0: FixedColumnWidth(50.0),
                                                  1: FixedColumnWidth(75.0),
                                                  2: FixedColumnWidth(90.0),
                                                  3: FixedColumnWidth(90.0),
                                                },
                                                // border: TableBorder.all(),
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Center(child: Icon(
                                                            Icons.check_circle_outline,
                                                            color: domains![index]['tasks']![index2]!["completed"]==false?Colors.red:Colors.green,)),
                                                        ),
                                                        TableCell(
                                                          child: Center(child: Text(
                                                              domains![index]['tasks']![index2]!["assignedTo"].
                                                              substring(0,domains![index]['tasks']![index2]!["assignedTo"].indexOf('@')))),
                                                        ),
                                                        TableCell(
                                                          child: Center(
                                                              child: Text(domains![index]['tasks']![index2]!["description"])),
                                                        ),
                                                        TableCell(
                                                          child: Center(
                                                              child: Text(domains![index]['tasks']![index2]!["deadline"])),
                                                        ),
                                                      ]
                                                  )
                                                ],
                                              )
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              );
                            },

                        ),
                      );
                    }
                  },
                ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: (){

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
                            Icon(Icons.arrow_circle_right_outlined)
                            ],
                          ),),
                      SizedBox(width: 20,),
      ElevatedButton(onPressed: (){
      },
        style:ElevatedButton.styleFrom(
          backgroundColor:Color.fromARGB(255, 225, 169, 229),
          // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),

        ),
        child:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Resources"),
            SizedBox(width:5),
            Icon(Icons.arrow_circle_right_outlined)
          ],
        ),),
                      ],
                    )
              ],
          ),
                ),
        ),
    );
  }
}
