import 'package:dreamfarm/Model/JobModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class JobCard extends StatelessWidget {
  JobCard({super.key, required this.job});

  JobModel job;
  Future<void> makeCall() async {
    final uri = Uri.parse(job.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 15),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                Icons.work_outline,
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
                    Text(job.title,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Text('${job.skills}',
                        style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18)),
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
                            "More Info",
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
