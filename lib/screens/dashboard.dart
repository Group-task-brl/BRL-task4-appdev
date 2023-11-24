import "package:flutter/material.dart";
class dashb_mem extends StatefulWidget {
  const dashb_mem({super.key});

  @override
  State<dashb_mem> createState() => dashb_memState();
}

class dashb_memState extends State<dashb_mem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Add Task"),),
      body: Container(
        child: Column(
          children:[
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
