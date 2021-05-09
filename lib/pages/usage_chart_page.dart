import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/models/history_data_model.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/usage_chart_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UsageChartPage extends StatefulWidget {
  final DeviceModel deviceModel;

  const UsageChartPage({Key? key, required this.deviceModel}) : super(key: key);

  @override
  _UsageChartPageState createState() => _UsageChartPageState();
}

class _UsageChartPageState extends State<UsageChartPage> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsageChartViewModel(widget.deviceModel),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Daily Usage"),
        ),
        body: Consumer<UsageChartViewModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  Material(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(DateFormat('hh:mm').format(DateTime.now()), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Text(DateFormat('  a').format(DateTime.now()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Today : " + DateFormat('yyyy/mm/dd').format(DateTime.now()), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Container(height: 12,),
                                Row(
                                  children: [
                                    Text("${model.monthlyUsage.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Text("  Kwh", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Monthly usage", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("${model.dailyUsage.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Text("  Kwh", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Power usage for today", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Container(height: 12,),
                                Row(
                                  children: [
                                    Text("${model.annualUsage.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Text("  Kwh", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Annual Usage", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                              color: Color(0xff232d37)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: model.data != null && model.data!.length > 0 ? LineChart(
                              mainData(model.data!, model.maxValue),
                            ) : SpinKitRing(color: AppColors.MAIN_COLOR, size: 50,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  LineChartData mainData(List<HistoryDataModel> data, double maxValue) {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            // if (value.toInt() == 1){
            //   return format(data[1].date.substring(8, 10));
            // }
            // if (data.length ~/ 2 == value.toInt()){
            //   return format(data[data.length ~/ 2].date.substring(8, 10));
            // }
            // if (data.length - 1 == value.toInt()){
            //   return format(data[data.length - 1].date.substring(8, 10));
            // }
            if (value % 2 == 0){
              return (value).toStringAsFixed(0);
            }
            return "";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            // return value.toInt() % getDivideValue(data) == 0 ? (value / 1000).toStringAsFixed(0) : "";
            print(value);
            if (maxValue < 1){
              if ((value * 100) % 10 == 0){
                return value.toString();
              }
            }
            else{
              return value.toString();
            }
            return "";
          },
          reservedSize: 16,
          margin: 8,
        ),
      ),

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      borderData:
      FlBorderData(show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: maxValue > 0 ? (maxValue.ceil() + 1) : (maxValue.ceil() + 1) * 10,
      lineBarsData: [
        LineChartBarData(
          spots: data.map((e) => FlSpot(data.indexOf(e).toDouble(), maxValue > 0 ? e.usage : e.usage * 10)).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            // show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }

  BarChart getBarChart(List<HistoryDataModel> data){
    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        minY: 0,
        maxY: 100,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (_a, _b, _c, _d) => null,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (value) {
              if (value.toInt() == 1){
                return format(data[1].date.substring(8, 10));
              }
              if (data.length ~/ 2 == value.toInt()){
                return format(data[data.length ~/ 2].date.substring(8, 10));
              }
              if (data.length - 1 == value.toInt()){
                return format(data[data.length - 1].date.substring(8, 10));
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
            margin: 12,
            reservedSize: 14,
            getTitles: (value) {
              return (value / 5).toString();
            },
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: data.map((e) => makeGroupData(data.indexOf(e), e.minAmount, e.usage, e.maxAmount)).toList(),
      ),
    );
  }


  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [Colors.green],
        width: 4,
      ),
      BarChartRodData(
        y: y2,
        colors: [Colors.white],
        width: 4,
      ),
      BarChartRodData(
        y: y3,
        colors: [Colors.red],
        width: 4,
      ),
    ]);
  }

  format(String date) {
    var suffix = "th";
    var digit = int.parse(date) % 10;
    if ((digit > 0 && digit < 4) && (int.parse(date) < 11 || int.parse(date) > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return date + suffix;
  }
}
