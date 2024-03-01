import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  bool isShow = false;

  void handleSignUp() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Placemark place = await _getAddressFromLatLng(pos);

    Map<dynamic, dynamic> reqBody = {
      "fullName": fullNameController.text,
      "username": userNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "latitude": pos.latitude,
      "longitude": pos.longitude,
      "address" : place
    };
    print(reqBody);
    Navigator.pushNamed(context, "/");
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<Placemark> _getAddressFromLatLng(Position position) async {
    List<Placemark> place =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return place[0];
    //     .then((List<Placemark> placemarks) {
    //   Placemark place = placemarks[0];
    //   setState(() {
    //     _currentAddress =
    //        '${place.street}, ${place.subLocality},
    //         ${place.subAdministrativeArea}, ${place.postalCode}';
    //   });
    // }).catchError((e) {
    //   debugPrint(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/images/login_bg.png"),
                height: 218.h,
                width: 390.w,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
                child: Text(
                  "Welcome to DreamFarm!",
                  style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF141C0D),
                      fontSize: 32.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: Text(
                  "Create account to access amazing features",
                  style: GoogleFonts.lexend(
                      fontSize: 16.sp,
                      color: const Color(0xFF141C0D),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: TextField(
                  controller: fullNameController,
                  style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFAFCF7),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      hintText: "Full Name",
                      hintStyle: GoogleFonts.lexend(
                          color: const Color(0xFF73964F), fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                              color: Color(0xFFDBE8D1), width: 1))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: TextField(
                  controller: userNameController,
                  style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFAFCF7),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      hintText: "User Name",
                      hintStyle: GoogleFonts.lexend(
                          color: const Color(0xFF73964F), fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                              color: Color(0xFFDBE8D1), width: 1))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: TextField(
                  controller: emailController,
                  style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFAFCF7),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      hintText: "Email",
                      hintStyle: GoogleFonts.lexend(
                          color: const Color(0xFF73964F), fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                              color: Color(0xFFDBE8D1), width: 1))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: TextField(
                  controller: passwordController,
                  style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal),
                  obscureText: isShow ? false : true,
                  decoration: InputDecoration(
                      suffixIcon: isShow
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isShow = false;
                                });
                              },
                              icon: Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isShow = true;
                                });
                              },
                              icon: Icon(Icons.visibility_off)),
                      filled: true,
                      fillColor: const Color(0xFFFAFCF7),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      hintText: "Password",
                      hintStyle: GoogleFonts.lexend(
                          color: const Color(0xFF73964F), fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                              color: Color(0xFFDBE8D1), width: 1))),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 5.h,
                ),
                child: Container(
                  height: 48.h,
                  width: 358.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color(0xFF80E51A)),
                  child: MaterialButton(
                    onPressed: () => handleSignUp(),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.lexend(
                            color: const Color(0xFF141C0D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    //Navigate to Sign Up Screen
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "Already have an account ? Sign up",
                    style: GoogleFonts.lexend(
                        color: const Color(0xFF141C0D),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
