import 'package:flutter/material.dart';
 import 'signup_step4.dart'; // Uncomment this if you have Step 4 ready

class SignupStep3 extends StatefulWidget {
  @override
  _SignupStep3State createState() => _SignupStep3State();
}

class _SignupStep3State extends State<SignupStep3> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final List<String> industries = [
    "Bollywood",
    "Tollywood",
    "Kollywood",
    "Mollywood",
    "Sandalwood"
  ];
  final Set<String> selectedIndustries = {};

  @override
  void dispose() {
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back and Title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Step Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(false),
                  _buildDot(false),
                  _buildDot(true), // Step 3 active
                  _buildDot(false),
                  _buildDot(false),
                ],
              ),
              SizedBox(height: 24),
              Text("Your industry background",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              // Chips
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: industries.map((industry) => _industryChip(industry)).toList(),
              ),
              SizedBox(height: 24),

              // Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _inputField("Experience", "Years", _experienceController),
                    SizedBox(height: 16),
                    _inputField("Short Bio", "Tell something about you.....",
                        _bioController,
                        maxLines: 4),
                  ],
                ),
              ),

              Spacer(),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (selectedIndustries.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select at least one industry')),
                        );
                        return;
                      }

                      // Collect data
                      print("Selected Industries: $selectedIndustries");
                      print("Experience: ${_experienceController.text}");
                      print("Bio: ${_bioController.text}");

                      // Navigate to Step 4
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => SignupStep4()),
                       );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("Next", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _industryChip(String label) {
    final isSelected = selectedIndustries.contains(label);
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.deepOrange : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            selectedIndustries.add(label);
          } else {
            selectedIndustries.remove(label);
          }
        });
      },
      selectedColor: Colors.deepOrange.shade100,
      backgroundColor: Color(0xFFFFF0E6),
      shape: StadiumBorder(),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) =>
              value == null || value.trim().isEmpty ? "$label is required" : null,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFFFF0E6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrange : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
