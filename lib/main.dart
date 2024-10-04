import 'package:dreamfarm/languages/language_constant.dart';
import 'package:dreamfarm/screens/Community/ChatScreen.dart';
import 'package:dreamfarm/screens/Community/CommunityPage.dart';
import 'package:dreamfarm/screens/Community/SearchScreen.dart';
import 'package:dreamfarm/screens/Community/UserProfile.dart';
import 'package:dreamfarm/screens/Community/add_post_screen.dart';
import 'package:dreamfarm/screens/CropDoc/CropDocInput.dart';
import 'package:dreamfarm/screens/CropRecommendations/crop_recommendations_screen.dart';
import 'package:dreamfarm/screens/JobOpportunity/job_listing.dart';
import 'package:dreamfarm/screens/JobOpportunity/skill_add.dart';
import 'package:dreamfarm/screens/MarketPlace/add_product.dart';
import 'package:dreamfarm/screens/MarketPlace/market_place.dart';
import 'package:dreamfarm/screens/MarketPlace/product_screen.dart';
import 'package:dreamfarm/screens/SensorData/sensor_data_screen.dart';
import 'package:dreamfarm/screens/Therapy/therapy_screen.dart';
import 'package:dreamfarm/screens/UserProfile/UserProfile.dart';
import 'package:dreamfarm/screens/home/ui/home_screen.dart';
import 'package:dreamfarm/screens/language_select/language_select.dart';
import 'package:dreamfarm/screens/login/ui/login_screen.dart';
import 'package:dreamfarm/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  //TODO: implement setLocale
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          title: 'DreamFarm',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: {
            "/": (context) => const HomeScreen(),
            "/language": (context) => const LanguageSelectScreen(),
            "/login": (context) => const LoginScreen(),
            "/signup": (context) => const SignUpScreen(),
            '/community': (context) => const CommunityPage(),
            '/search': (context) => const SearchScreen(),
            '/userprofile': (context) => const UserProfilePage(),
            '/chat': (context) => const ChatScreen(),
            '/account': (context) => const Account(),
            '/cropdoc-input': (context) => const CropDocInput(),
            '/marketplace': (context) =>  MarketplaceScreen(),
            '/product': (context) => ProductScreen(

            ),
            //'/networks': (context) => NetworksScreen(),
            '/skill': (context) => const SkillAddScreen(),
            '/job' : (context) =>  JobListingScreen(),
            '/addproduct': (context) => AddProductScreen(),
            '/addpost': (context) => AddPostScreen(),
            '/therapy' : (context) => TherapyScreen(),
            '/recommend': (context) => CropRecommendationScreen(),
            '/sensor' : (context) => SensorDataScreen()
          },
          initialRoute: "/",
        );
      },
    );
  }
}
