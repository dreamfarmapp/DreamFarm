import 'package:dreamfarm/Model/ServiceModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCard extends StatelessWidget {
  ServiceModel service;
  ServiceCard({super.key, required this.service});

  Future<void> makeCall() async {
    var url = Uri.parse("tel:${service.phoneNumber}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 15),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                Icons.agriculture,
                size: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(7, 0, 15, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.title,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Text('${service.phoneNumber}',
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18)),
                    Row(mainAxisSize: MainAxisSize.max, children: [
                      Text('Distance:',
                          style: GoogleFonts.lexend(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18)),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text('${service.distance} Km',
                            style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                      ),
                    ]),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF80E51A)),
                      child: MaterialButton(
                        onPressed: () {
                          makeCall();
                        },
                        child: Center(
                          child: Text(
                            "Contact",
                            style: GoogleFonts.lexend(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
