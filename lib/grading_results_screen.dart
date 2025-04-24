import 'package:flutter/material.dart';

// Assuming you have added the Pacifico font to your project
// and declared it in pubspec.yaml.
// You will also need built-in Flutter icons or a custom icon font for the icons.

class GradingResultsScreen extends StatefulWidget {
  // This screen will likely receive the results data
  // from the previous screen (MainFormScreen)
  final Map<String, dynamic> gradingData;

  const GradingResultsScreen({
    Key? key,
    // Accept grading data as a parameter
    required this.gradingData,
  }) : super(key: key);

  @override
  _GradingResultsScreenState createState() => _GradingResultsScreenState();
}

class _GradingResultsScreenState extends State<GradingResultsScreen> {
  // Mock data structure based on the HTML script
  // Replace this with actual data passed to the widget
  late Map<String, dynamic> _results;

  @override
  void initState() {
    super.initState();
    // Use the data passed to the widget
    _results = widget.gradingData;

    // If you were using the mock data directly without passing:
    // _results = {
    //   'grade': 'A+',
    //   'quality': 'Excellent Quality',
    //   'details': {
    //     'color': 'Deep Red (#98)',
    //     'size': 'Large (72mm)',
    //     'shape': 'Regular',
    //     'defects': 'None',
    //     'firmness': 'Excellent'
    //   }
    // };
  }


  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Approximate position
      ),
    );
  }

  void _saveResult() {
    // TODO: Implement actual save logic
    print('Saving result: ${_results}'); // Placeholder print
    _showToast('Result saved successfully');
  }

  void _shareResult() {
    // TODO: Implement actual share logic
    print('Sharing result: ${_results}'); // Placeholder print
    _showToast('Sharing options opened');
  }


  @override
  Widget build(BuildContext context) {
    // Assuming the target width is 375px as per the HTML
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth > 375 ? 375 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.grey[100], // bg-gray-50 approx
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0, // border-b border-gray-100 shadow-sm approx
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey), // ri-arrow-left-s-line text-xl text-gray-700
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Grading Results',
          style: TextStyle(
            fontSize: 18.0, // text-lg
            fontWeight: FontWeight.w500, // font-medium
            color: Colors.black, // text-gray-900
          ),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), // Placeholder for right side
        ],
      ),
      body: Center(
        child: Container(
          width: containerWidth,
          color: Colors.white, // bg-white for the content area
          child: SingleChildScrollView( // Allows scrolling if content overflows
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).copyWith(top: 20.0 + kToolbarHeight), // pt-20 + pb-20 approx, considering AppBar height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // stretch items to full width
              children: [
                // Grade Display
                Container(
                  padding: const EdgeInsets.all(32.0), // p-8
                  margin: const EdgeInsets.only(bottom: 24.0), // mb-6
                  decoration: BoxDecoration(
                    color: Colors.green[50], // bg-green-50
                    borderRadius: BorderRadius.circular(8.0), // rounded-lg
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05), // shadow-sm approx
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _results['grade'] ?? '-', // Display grade, default to '-' if null
                        style: TextStyle(
                          fontSize: 80.0, // text-[80px]
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600], // text-green-600
                        ),
                      ),
                      const SizedBox(height: 8.0), // mt-2 approx
                      Text(
                        _results['quality'] ?? 'N/A', // Display quality, default to 'N/A' if null
                        style: TextStyle(
                          color: Colors.green[600], // text-green-600
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Detailed Analysis
                Container(
                  padding: const EdgeInsets.all(16.0), // p-4
                  margin: const EdgeInsets.only(bottom: 24.0), // mb-6
                  decoration: BoxDecoration(
                    color: Colors.white, // bg-white
                    borderRadius: BorderRadius.circular(8.0), // rounded-lg
                    border: Border.all(color: Colors.grey[300]!), // border border-gray-200 approx
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05), // shadow-sm approx
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0), // mb-4
                        child: Text(
                          'Detailed Analysis',
                          style: TextStyle(
                            fontSize: 18.0, // text-lg
                            fontWeight: FontWeight.w500, // font-medium
                            color: Colors.black, // text-gray-900
                          ),
                        ),
                      ),
                      // Analysis details list
                      if (_results['details'] is Map) // Check if details is a map
                        ...(_results['details'] as Map).entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0), // space-y-4 / 2 approx
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key, // Detail name (e.g., Color, Size)
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700], // text-gray-600 approx
                                  ),
                                ),
                                Text(
                                  entry.value.toString(), // Detail value
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black, // text-gray-900 approx
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()
                      else
                        const Text('Analysis details not available'),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveResult,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5), // primary color (indigo-600 from the third HTML)
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12.0), // py-3
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // !rounded-button
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.save_alt, size: 20.0), // ri-save-line approx
                            SizedBox(width: 8.0), // mr-2
                            Text(
                              'Save Result',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0), // gap-4
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _shareResult,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981), // secondary color (emerald-500 from the third HTML)
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12.0), // py-3
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // !rounded-button
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.share, size: 20.0), // ri-share-line approx
                            SizedBox(width: 8.0), // mr-2
                            Text(
                              'Share',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // The toast is handled by ScaffoldMessenger, not a fixed position widget in modern Flutter
    );
  }
}