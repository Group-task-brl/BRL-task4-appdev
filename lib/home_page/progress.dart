import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:brl_task4/models/appbar.dart';
import 'package:brl_task4/home_page/tasks.dart';

class ProgressChart extends StatefulWidget {
  // int? compNum = completedTaskNum;
  // final int incompNum;

  const ProgressChart({Key? key}) : super(key: key);

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  Widget build(BuildContext context) {
    double totalTasks = (completedTaskNum! + incompleteTaskNum!).toDouble();
    double completedTasks = (completedTaskNum! / totalTasks) * 100.0;
    double incompleteTasks = (incompleteTaskNum! / totalTasks) * 100.0;

    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
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
