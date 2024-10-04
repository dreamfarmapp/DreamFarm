import 'dart:convert';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dreamfarm/languages/language_constant.dart'; // Import for i18n

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api_key = "6a58e10ed6e9f90ebb7148bf5b2ff687";
  dynamic temp = "22";
  dynamic description = "Clear Sky";
  dynamic imageUrl = "https://openweathermap.org/img/wn/10d@2x.png";
  dynamic humidity = 62;
  dynamic windspeed = 0.62;
  String alert = "Warning : There is a high probabilty storm";

  //State Variables for UI
  bool isLoading = true;
  bool isAlert = false;

  Future<void> getWeatherDetails(double lat, double lon) async {
    final getWeatherEndpoint =
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${api_key}&units=metric";
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(getWeatherEndpoint));
    final respBody = await jsonDecode(response.body);
    print(respBody);
    FocusScope.of(context).unfocus();

    setState(() {
      temp = respBody['main']['temp'].toString();
      description = respBody['weather'][0]['description'];
      imageUrl =
          "https://openweathermap.org/img/wn/${respBody['weather'][0]['icon']}@2x.png";
      humidity = respBody['main']['humidity'].toString();
      windspeed = respBody['wind']['speed'].toString();
      isLoading = false;
    });
  }

  Future<void> getWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<dynamic, dynamic> user = jsonDecode(prefs.getString("user")!);
    getWeatherDetails(user['latitude'], user['longitude']);
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(165, 214, 167, 1),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/account");
            },
            icon: Icon(Icons.account_circle_outlined),
          )
        ],
        centerTitle: true,
        title: Text(translation(context).dreamfarm), // i18n key
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                translation(context).menu, // i18n key
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text(translation(context).cropdoc), // i18n key
              onTap: () {
                Navigator.pushNamed(context, "/cropdoc-input");
              },
            ),
            ListTile(
              title: Text(translation(context).crop_recommendations), // i18n key
              onTap: () {
                Navigator.pushNamed(context, "/recommend");
              },
            ),
            ListTile(
              title: Text(translation(context).services), // i18n key
              onTap: () {
                 makeCall("http://172.168.74.38:8501");
              },
            ),
            ListTile(
              title: Text(translation(context).yield_predictor), // i18n key
              onTap: () {
                 makeCall("http://172.168.74.38:8502");
              },
            ),
            ListTile(
              title: Text(translation(context).job_opportunities), // i18n key
              onTap: () {
                Navigator.pushNamed(context, '/skill');
              },
            ),
            ListTile(
              title: Text(translation(context).sensor_data), // i18n key
              onTap: () {
                Navigator.pushNamed(context, '/sensor');
              },
            ),
             ListTile(
              title: Text(translation(context).select_language), // i18n key
              onTap: () {
                Navigator.pushNamed(context, '/language');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              child: Text(
                translation(context).current_weather_data, // i18n key
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            isAlert
                ? Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.red)),
                    child: Center(
                      child: Text(
                        alert,
                        style: GoogleFonts.lexend(color: Colors.red),
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  WeatherInfoCard(
                    icon: Icons.thermostat_outlined,
                    label: translation(context).temperature, // i18n key
                    value: '$temp°C',
                  ),
                  WeatherInfoCard(
                    icon: Icons.cloud,
                    label: translation(context).weather, // i18n key
                    value: description,
                  ),
                  WeatherInfoCard(
                    icon: Icons.water_outlined,
                    label: translation(context).humidity, // i18n key
                    value: '$humidity%',
                  ),
                  WeatherInfoCard(
                    icon: Icons.air_outlined,
                    label: translation(context).wind_speed, // i18n key
                    value: '$windspeed m/s',
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.green,
              child: Text(
                translation(context).services, // i18n key
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                     makeCall("http://172.168.74.38:8501");
                  },
                  child: ServiceContainer(
                      icon: Icons.agriculture,
                      label: translation(context).soil_testing), // i18n key
                ),
                GestureDetector(
                  onTap: () {
                    makeCall("http://172.168.74.38:8501");
                  },
                  child: ServiceContainer(
                      icon: Icons.storage,
                      label: translation(context).storage_facilities), // i18n key
                ),
              ],
            ),
            SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {
          if (value == 1)
            {Navigator.pushNamed(context, "/community")}
          else if (value == 0)
            {Navigator.pushNamed(context, "/")}
          else if (value == 2)
            {Navigator.pushNamed(context, "/marketplace")}
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: translation(context).home, // i18n key
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/community_black.png",
              height: 20,
            ),
            label: translation(context).community, // i18n key
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: translation(context).marketplace, // i18n key
          ),
        ],
      ),
    );
  }
}

class ServiceContainer extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceContainer({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 50),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 60, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
