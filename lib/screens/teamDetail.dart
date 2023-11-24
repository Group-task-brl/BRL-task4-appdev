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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: Text("Team A"),),
        body: Container(
          child: Column(
            children:[
              Table(
              border: TableBorder.all(),
                children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Center(child: Icon(Icons.check_circle_outline)),
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
                  TableRow(
                    children:[
                      TableCell(
                        child: Center(child: Icon(Icons.check_circle_outline,color: Colors.red,)),
                      ),
                      TableCell(
                        child: Center(child: Text('Maansi')),
                      ),
                      TableCell(
                        child: Center(child: Text('Create App')),
                      ),
                      TableCell(
                        child: Center(child:Text("29-11-23") ),
                      ),
                    ]
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
