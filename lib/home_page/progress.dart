import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:brl_task4/models/appbar.dart';

class ProgressChart extends StatelessWidget {
  //%
  final double completedTasks = 70.0; 
  final double incompleteTasks = 30.0;

  const ProgressChart({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                //completed task
                color: Colors.green,
                value: completedTasks,
                title: '$completedTasks%',
                radius: 80.0,
                titleStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                //incomp task
                color: Colors.red, 
                value: incompleteTasks,
                title: '$incompleteTasks%',
                radius: 80.0,
                titleStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 60.0,
            startDegreeOffset: -90,
          ),
        ),
      ),
    );
  }
}