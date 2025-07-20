import 'package:flutter/material.dart';
import 'signup_step3.dart';

class SignupStep2 extends StatefulWidget {
  @override
  _SignupStep2State createState() => _SignupStep2State();
}

class _SignupStep2State extends State<SignupStep2> {
  final List<String> roles = ['Actor', 'Director', 'Producer'];
  final List<String> complexions = ['Fair', 'Wheatish', 'Dusky', 'Dark'];
  final List<String> genders = ['Male', 'Female', 'Other'];

  String? selectedRole;
  String? selectedComplexion;
  String? selectedGender;
  double selectedAge = 25;

  final _formKey = GlobalKey<FormState>();

  final Color orange = Color(0xFFFF4400); // Active and button color
  final Color background = Color(0xFFFFF0E6); // Dropdown background color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Dots Progress Indicator
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => _buildDot(index == 1)), // 2nd dot active
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  "Tell us more about you",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 24),

                // Role Dropdown
                _buildLabel("Role"),
                _buildDropdown(
                  roles,
                  selectedRole,
                  (value) => setState(() => selectedRole = value),
                  "Select your role",
                ),

                // Gender ChoiceChips
                _buildLabel("Gender"),
                Wrap(
                  spacing: 8,
                  children: genders.map((gender) {
                    final isSelected = selectedGender == gender;
                    return ChoiceChip(
                      label: Text(gender),
                      selected: isSelected,
                      onSelected: (_) => setState(() => selectedGender = gender),
                      selectedColor: orange.withOpacity(0.2),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? orange : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 24),

                // Age Slider
                _buildLabel("Age"),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: selectedAge,
                        min: 10,
                        max: 100,
                        divisions: 90,
                        activeColor: orange,
                        inactiveColor: Colors.grey.shade300,
                        onChanged: (value) => setState(() => selectedAge = value),
                      ),
                    ),
                    Text(selectedAge.toInt().toString()),
                  ],
                ),

                SizedBox(height: 16),

                // Complexion Dropdown
                _buildLabel("Complexion"),
                _buildDropdown(
                  complexions,
                  selectedComplexion,
                  (value) => setState(() => selectedComplexion = value),
                  "Select your complexion",
                ),

                Spacer(),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedRole == null ||
                          selectedGender == null ||
                          selectedComplexion == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill all the fields"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("All good! Proceeding..."),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignupStep3()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
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
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String? selected,
    Function(String?) onChanged,
    String hint,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonFormField<String>(
        value: selected,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        icon: Icon(Icons.expand_more),
        style: TextStyle(color: Colors.black),
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? orange : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
