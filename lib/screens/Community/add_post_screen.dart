import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isLoading = false;

  void handleSubmit() {}

  final TextEditingController _imageUrlController = TextEditingController();
  File? _imageFile;

  Future<void> _uploadImageToCloudinary(File imageFile) async {
    final cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/ddkpclbs2/image/upload';
    final uploadPreset = 'bisineimages';

    final uri = Uri.parse(cloudinaryUrl);

    // Create multipart request for uploading
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    // Send request
    final response = await request.send();

    // Get response body as a Map
    final responseBody = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseBody);

    // Extract the URL from the response
    final imageUrl = decodedResponse['secure_url'];
    print(imageUrl);

    setState(() {
      _imageUrlController.text = imageUrl;
    });
  }

  Future<void> _pickImage() async {
    setState(() {
      isLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _imageFile = file;
      });

      // Upload the selected image to Cloudinary
      await _uploadImageToCloudinary(file);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pushNamed(context, '/services');
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
          ],
        ),
      ),
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
              "assets/icons/community_green.png",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Title",
                style: GoogleFonts.lexend(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              TextField(
                controller: titleController,
                style: GoogleFonts.lexend(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFAFCF7),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Product Name",
                    hintStyle: GoogleFonts.lexend(
                        color: const Color(0xFF73964F), fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFDBE8D1), width: 1))),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Description",
                style: GoogleFonts.lexend(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              TextField(
                controller: descController,
                maxLines: 5,
                style: GoogleFonts.lexend(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFAFCF7),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "description",
                    hintStyle: GoogleFonts.lexend(
                        color: const Color(0xFF73964F), fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFDBE8D1), width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Select Image'),
                  ),
                  isLoading ? Text("Uploading...") : SizedBox()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: 358,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF80E51A)),
                child: MaterialButton(
                  onPressed: () => handleSubmit(),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.lexend(
                          color: const Color(0xFF141C0D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
