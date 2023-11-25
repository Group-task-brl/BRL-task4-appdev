
import "package:brl_task4/Utils/Routes.dart";
import "package:flutter/material.dart";
class dashb_mem extends StatefulWidget {
  const dashb_mem({super.key});

  @override
  State<dashb_mem> createState() => dashb_memState();
}

class dashb_memState extends State<dashb_mem> {
  Future<void>? _futureData;
  void initState() {
    super.initState();
    // _futureData =api();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Dashboard"),),
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
                      return ListView.builder(
                       itemCount:3,
                        itemBuilder: (context,index){
                            return ListTile(
                              title: ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context,MyRoutes.tdetailRoutes);
                                },
                                child: Text("Team A"),
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
