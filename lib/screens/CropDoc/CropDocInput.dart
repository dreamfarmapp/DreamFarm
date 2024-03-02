import 'dart:io';
import 'package:dreamfarm/Model/HomeScreenData.dart';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CropDocInput extends StatefulWidget {
  const CropDocInput({super.key});

  @override
  State<CropDocInput> createState() => _CropDocInputState();
}

class _CropDocInputState extends State<CropDocInput> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   setState(() {
    //     _selectedImage = File(pickedFile.path);
    //   });
    // }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/account");
            },
            icon: Icon(Icons.account_circle_outlined),
          )
        ],
        centerTitle: true,
        title: Text('DreamFarm'),
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
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Crop Doc'),
              onTap: () {
                Navigator.pushNamed(context, "/cropdoc-input");
                // Implement option 1 functionality here
              },
            ),
            ListTile(
              title: Text('Services'),
              onTap: () {
                 makeCall("http://192.168.137.36:8501");
                // Implement option 2 functionality here
              },
            ),
            ListTile(
              title: Text('Job Opportunities'),
              onTap: () {
                Navigator.pushNamed(context, '/skill');
                // Implement option 2 functionality here
              },
            ),

             ListTile(
              title: Text('Therapy'),
              onTap: () {
                Navigator.pushNamed(context, "/therapy");
                // Implement option 1 functionality here
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/community_black.png",
              height: 20,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'MarketPlace',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Input an image of a crop infection to be analyzed:',
              style: GoogleFonts.roboto(color: Colors.black),
            ),
            SizedBox(height: 10),
            if (_selectedImage != null)
              Image.file(_selectedImage!, width: 200, height: 200)
            else
              IconButton(
                  onPressed: () {
                    _pickImage();
                  },
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.grey,
                    size: 50.h,
                  )),
          ],
        ),
      ),
    );
  }
}
