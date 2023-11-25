import "package:flutter/material.dart";
import 'package:table_calendar/table_calendar.dart';
class t_detail extends StatefulWidget {
  const t_detail({super.key});

  @override
  State<t_detail> createState() => _t_detailState();
}

class _t_detailState extends State<t_detail> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.utc(2021, 11, 29); // Set the initial focus day
  DateTime? _selectedDay;
  Future<void>? _futureData;
  void initState() {
    super.initState();
    // _futureData =api();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: Text("Team A"),),
        body: SafeArea(
          child: Container(
            child: Column(
              children:[
                Text("Leader - Sir"),
                SizedBox(height: 10,),
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(60.0),
                    1: FixedColumnWidth(90.0),
                    2: FixedColumnWidth(100.0),
                    3: FixedColumnWidth(80.0),
                  },
                border: TableBorder.all(),
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
                          return Expanded(
                            child: ListView.builder(
                            itemCount:3,
                              itemBuilder: (context,index) {
                                return ListTile(
                                  title: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(60.0),
                                      1: FixedColumnWidth(90.0),
                                      2: FixedColumnWidth(100.0),
                                      3: FixedColumnWidth(80.0),
                                    },
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(child: Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.red,)),
                                            ),
                                            TableCell(
                                              child: Center(child: Text('Maansi')),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text('Create App')),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text("29-11-23")),
                                            ),
                                          ]
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
            ],
          ),
                ),
        ),
    );
  }
}
