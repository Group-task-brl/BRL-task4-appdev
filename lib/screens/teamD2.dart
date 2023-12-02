import 'package:flutter/material.dart';

class team extends StatefulWidget {
  const team({super.key});

  @override
  State<team> createState() => _teamState();
}

class _teamState extends State<team> {
  Future<void>? _futureData;
  @override
  void initState() {
    super.initState();
    // _futureData =api();
  }

  Future<List<TableRow>> fetchData() async {
    List<TableRow> data = [
      // for(int i=0;i<2;i++){
      const TableRow(
        children: [
          TableCell(
            child: Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.red,
              ),
            ),
          ),
          TableCell(
            child: Center(child: Text('Maansi')),
          ),
          TableCell(
            child: Center(child: Text('Create App')),
          ),
          TableCell(
            child: Center(child: Text("29-11-23")),
          ),
        ],
      ),
  // }
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Container(
          color: Colors.black,
          width: 190,
            child: Column(
              children:[
                const SizedBox(height: 50,),
                const Text("Team A",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 50,),
                TextButton(child: const Text("Add Task"),onPressed: (){},),
                const SizedBox(height: 10,),
                TextButton(child: const Text("Resources"),onPressed: (){},),
              ]
            ),
          ),
          appBar:AppBar(title: const Text("Team A"),),
          body: SafeArea(
            child:Container(
              child: Column(
                children: [
                  const Text("Leader - Sir"),
                  const SizedBox(height:20),
                  FutureBuilder<void>(
                    future: _futureData,
                      builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                          color:Colors.white,
                        ),
                      );
                    } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                    } else {
                      return  SizedBox(
                        height: 600,
                        child: ListView.builder(
                          itemCount:2,
                          itemBuilder: (context,index) {
                          return ListTile(
                            title: Column(
                            children: [
                            const Text("Domain - Specific"),
                            const SizedBox(height: 10,),
                            Table(
                              columnWidths: const {
                                0: FixedColumnWidth(60.0),
                                1: FixedColumnWidth(80.0),
                                2: FixedColumnWidth(85.0),
                                3: FixedColumnWidth(80.0),
                              },
                              border: TableBorder.all(),
                              children: const [
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
                                ),
                              ],
                            ),]
                          ),
                        );
                      }
                    ),);
                }},
             ),],
              ),
            ) ,
          ),
    );
  }
}
