import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class GraphWidget extends StatefulWidget {
  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  late List<_ChartData> data;

  @override
  void initState() {
    super.initState();

    var r = Random();
    data = List<_ChartData>.generate(30, (i) => _ChartData(i, r.nextDouble() * 1500));
  }

  void _onSelectionChanged(SelectionArgs args) {
    //final selectedPoint = args.seriesRenderer;
     if (args.pointIndex != null) {
      final int index = args.pointIndex!;
      final _ChartData selectedData = data[index];

      print('Index: ${selectedData.x}');
      print('Value: ${selectedData.y}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: const NumericAxis(
            interval: 5,
            majorTickLines: MajorTickLines(size: 0),
            minorTickLines: MinorTickLines(size: 0),
            title: AxisTitle(text: 'Days'),
            labelFormat: '{value}',
            
          ),
          primaryYAxis: const NumericAxis(
            interval: 500,
            title: AxisTitle(text: 'Gasto'),
          ),
          series: <LineSeries<_ChartData, int>>[
            LineSeries<_ChartData, int>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              color: Colors.blue,
              width: 4,
              selectionBehavior: SelectionBehavior(
                enable: true,
              ),
              // markerSettings: const MarkerSettings(
              //   isVisible: true,
              //   color: Colors.red,
              //   borderWidth: 2,
              //   borderColor: Colors.black,
              // ),
              // dataLabelSettings: const DataLabelSettings(
              //   isVisible: true,
              // ),
            ),
          ],
          trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: const InteractiveTooltip(
              enable: true,
            ),
          ),
          onSelectionChanged: _onSelectionChanged,
        ),
      ),
    );
  }
}


class _ChartData {
  _ChartData(this.x, this.y);

  final int x;
  final double y;
}