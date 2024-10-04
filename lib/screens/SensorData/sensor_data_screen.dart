import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorDataScreen extends StatefulWidget {
  const SensorDataScreen({Key? key}) : super(key: key);

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  bool _isLoading = false;
  List<Map<String, String>> _sensorDataList = [];

  Future<void> _fetchSensorData() async {
    setState(() {
      _isLoading = true;
    });

    const String url =
        'https://api.thingspeak.com/channels/2195559/feeds.json?api_key=AWTMEFCOV3NSRRC7&results=25';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Map<String, String>> tempData = [];
        for (var feed in data['feeds']) {
          tempData.add({
            'created_at': feed['created_at'],
            'temperature': feed['field1'],
            'humidity': feed['field2'],
            'moisture': feed['field3'],
          });
        }

        setState(() {
          _sensorDataList = tempData.reversed.toList();
        });
      } else {
        throw Exception('Failed to load sensor data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatTimestamp(String isoTimestamp) {
    try {
      DateTime utcDate = DateTime.parse(isoTimestamp);
      DateTime istDate = utcDate.add(const Duration(hours: 5, minutes: 30));
      return DateFormat('dd MMM yyyy, hh:mm a').format(istDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  List<FlSpot> _getTemperatureSpots() {
    return _sensorDataList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              double.tryParse(entry.value['temperature']!) ?? 0.0,
            ))
        .toList();
  }

  List<FlSpot> _getHumiditySpots() {
    return _sensorDataList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              double.tryParse(entry.value['humidity']!) ?? 0.0,
            ))
        .toList();
  }

  List<FlSpot> _getMoistureSpots() {
    return _sensorDataList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              double.tryParse(entry.value['moisture']!) ?? 0.0,
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  Widget _buildGraph(String title, List<FlSpot> spots, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() < _sensorDataList.length) {
                        return Text(
                          _formatTimestamp(_sensorDataList[value.toInt()]['created_at']!),
                          style: const TextStyle(fontSize: 8),
                          textAlign: TextAlign.center,
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toString(), style: const TextStyle(fontSize: 10));
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: color,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGraph('Temperature', _getTemperatureSpots(), Colors.red),
                    _buildGraph('Humidity', _getHumiditySpots(), Colors.blue),
                    _buildGraph('Soil Moisture', _getMoistureSpots(), Colors.green),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _sensorDataList.length,
                      itemBuilder: (context, index) {
                        final sensorData = _sensorDataList[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          color: Colors.green[50],
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              'Timestamp: ${_formatTimestamp(sensorData['created_at']!)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Temperature: ${sensorData['temperature']} °C'),
                                Text('Humidity: ${sensorData['humidity']} %'),
                                Text('Soil Moisture: ${sensorData['moisture']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchSensorData,
        backgroundColor: Colors.green[200],
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
