import 'dart:convert';
import 'dart:io';
import 'package:dreamfarm/services/launchUrl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CropDocInput extends StatefulWidget {
  const CropDocInput({Key? key}) : super(key: key);

  @override
  State<CropDocInput> createState() => _CropDocInputState();
}

class _CropDocInputState extends State<CropDocInput> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _apiResponse = '';
  bool _isLoading = false;
  String _cloudinaryImageUrl = '';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _uploadToCloudinary(File image) async {
    final cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/ddkpclbs2/image/upload'; // Replace with your Cloudinary details
    final preset = 'bisineimages'; // Replace with your upload preset

    var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.fields['upload_preset'] = preset;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonResponse = json.decode(responseString);

    setState(() {
      _cloudinaryImageUrl = jsonResponse['secure_url'];
    });
  }

  Future<void> _sendLinkToBackend(String imageUrl) async {
    const backendUrl =
        'http://10.0.2.2:3000/analyze-image'; // Replace with your backend URL

    print(imageUrl);

    var response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'imageUrl': imageUrl,
        'prompt':
            'Analyze the disease in this crop image and suggest possible remedies.',
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _apiResponse = json.decode(response.body)['analysis'] ??
            'No response from backend.';
      });
    } else {
      setState(() {
        _apiResponse =
            'Failed to get response from backend. Error: ${response.statusCode}';
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      //First upload the image to Cloudinary
      await _uploadToCloudinary(_selectedImage!);

      // After uploading to Cloudinary, send the image URL to the backend
      if (_cloudinaryImageUrl.isNotEmpty) {
        await _sendLinkToBackend(_cloudinaryImageUrl);
      }
    } catch (e) {
      setState(() {
        _apiResponse = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
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
              title: Text('Crop Recommendations'),
              onTap: () {
                Navigator.pushNamed(context, "/recommend");
                // Implement option 1 functionality here
              },
            ),
            ListTile(
              title: Text('Services'),
              onTap: () {
                 makeCall("http://192.168.1.4:8501");
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
            // ListTile(
            //   title: Text('Therapy'),
            //   onTap: () {
            //     Navigator.pushNamed(context, "/therapy");
            //     // Implement option 1 functionality here
            //   },
            // ),
          ],       ),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text(
                'Input an image of a crop infection to be analyzed:',
                style: GoogleFonts.roboto(color: Colors.black),
              ),
              SizedBox(height: 10),
              if (_selectedImage != null)
                GestureDetector(
                  onTap: _pickImage,
                  child: Image.file(_selectedImage!, width: 200, height: 200),
                )
              else
                IconButton(
                  onPressed: _pickImage,
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.grey,
                    size: 50.h,
                  ),
                ),
              SizedBox(height: 20),
              if (_selectedImage != null)
                ElevatedButton(
                  onPressed: _isLoading ? null : _analyzeImage,
                  child: Text(_isLoading ? 'Analyzing...' : 'Analyze Image'),
                ),
              SizedBox(height: 20),
              if (_apiResponse.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:  MarkdownBody(
                    data: _apiResponse,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
