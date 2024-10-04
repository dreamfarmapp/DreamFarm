import 'package:dreamfarm/languages/language.dart';
import 'package:dreamfarm/languages/language_constant.dart';
import 'package:dreamfarm/main.dart';
import 'package:flutter/material.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final bodyHeight = screenHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).dreamfarm),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: bodyHeight,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              translation(context).selectLanguage,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, ),
            ),
            SizedBox(height: 20),
            ...Language.languageList()
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (e != null) {
                              Locale locale = await setLocale(e.languageCode);
                              MyApp.setLocale(context, locale);
                            }
                          },
                          child: Center(
                            child: Text(
                              e.name,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    translation(context).cont,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
