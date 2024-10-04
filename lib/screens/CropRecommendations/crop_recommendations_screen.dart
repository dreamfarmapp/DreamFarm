import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({Key? key}) : super(key: key);

  @override
  _CropRecommendationScreenState createState() => _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _markdownContent = '';
  bool _isLoading = false;

  Future<void> _getRecommendation() async {
    setState(() {
      _isLoading = true;
    });

    final String city = _cityController.text.trim();
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/recommend-crops'), // Replace with your actual backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'city': city}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _markdownContent = data['recommendation'] ?? 'No recommendation available.';
        });
      } else {
        throw Exception('Failed to load recommendation');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
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
        title: const Text('Crop Recommendation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getRecommendation,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Recommend'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _markdownContent.isNotEmpty
                  ? Markdown(data: _markdownContent)
                  : const Center(child: Text('Enter a city and press Recommend')),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}