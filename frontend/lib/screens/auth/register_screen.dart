import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String role = 'Actor';
  String customRole = '';
  String gender = 'Male';
  String industry = 'Bollywood';
  String complexion = 'Fair';
  String experience = '';
  String description = '';
  String contact = '';
  String age = '';

  List<File> selectedImages = [];
  bool isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final ImagePicker _picker = ImagePicker();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final picked = await _picker.pickMultiImage();
    if (picked != null) {
      setState(() {
        selectedImages.addAll(picked.map((e) => File(e.path)).toList());
      });
    }
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least 1 photo')),
      );
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.241.53.205:8080/api/auth/register'),

      );

      request.fields.addAll({
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role == 'Other' ? customRole : role,
        'gender': gender,
        'industry': industry,
        'complexion': complexion,
        'experience': experience,
        'description': description,
        'contact': contact,
        'age': age,
      });

      for (var i = 0; i < selectedImages.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath('photos', selectedImages[i].path),
        );
      }

      var response = await request.send();
final responseBody = await response.stream.bytesToString();
print('Response status: ${response.statusCode}');
print('Response body: $responseBody');
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Registered successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Invalid credentials or server error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 195, 202, 211),
              Color.fromARGB(255, 230, 247, 243)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 380,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Icon(Icons.app_registration,
                          color: Colors.teal, size: 60),
                      const SizedBox(height: 20),
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              'First Name',
                              (v) => firstName = v,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: buildTextField(
                              'Middle Name',
                              (v) => middleName = v,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: buildTextField(
                              'Last Name',
                              (v) => lastName = v,
                            ),
                          ),
                        ],
                      ),
                      buildTextField(
                        'Email',
                        (v) => email = v,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      buildPasswordField(
                        'Password',
                        (v) => password = v,
                        _passwordVisible,
                        () => setState(
                            () => _passwordVisible = !_passwordVisible),
                      ),
                      buildPasswordField(
                        'Confirm Password',
                        (v) => confirmPassword = v,
                        _confirmPasswordVisible,
                        () => setState(() =>
                            _confirmPasswordVisible = !_confirmPasswordVisible),
                      ),
                      role != 'Other'
                          ? buildDropdown(
                              'Role',
                              role,
                              [
                                'Actor',
                                'Actress',
                                'Director',
                                'Producer',
                                'Choreographer',
                                'Anchor',
                                'Makeup Artist',
                                'Fight Master',
                                'Musicians',
                                'Cameraman',
                                'Other'
                              ],
                              (v) {
                                setState(() {
                                  role = v;
                                  if (v != 'Other') customRole = '';
                                });
                              },
                            )
                          : buildTextField(
                              'Enter Role',
                              (v) => customRole = v,
                            ),
                      buildDropdown(
                        'Gender',
                        gender,
                        ['Male', 'Female', 'Others'],
                        (v) => gender = v,
                      ),
                      buildTextField(
                        'Age',
                        (v) => age = v,
                        keyboardType: TextInputType.number,
                      ),
                      buildDropdown(
                        'Industry',
                        industry,
                        [
                          'Bollywood',
                          'Tollywood',
                          'Kollywood',
                          'Mollywood',
                          'Sandalwood',
                          'Hollywood',
                          'Pollywood',
                          'Bhojiwood',
                          'Marathi',
                          'Bengali',
                          'Gujarati',
                          'Punjabi'
                        ],
                        (v) => industry = v,
                      ),
                      buildDropdown(
                        'Complexion',
                        complexion,
                        [
                          'Very Fair',
                          'Fair',
                          'Wheatish',
                          'Dusky',
                          'Dark'
                        ],
                        (v) => complexion = v,
                      ),
                      buildTextField('Experience', (v) => experience = v),
                      buildTextField('Description', (v) => description = v),
                      buildTextField(
                        'Contact Number',
                        (v) => contact = v,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: pickImages,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Select Photos'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedImages
                            .map(
                              (f) => Image.file(
                                f,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 50),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Already have an account? Login',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    Function(String) onSaved, {
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: (v) => v!.isEmpty ? 'Enter $label' : null,
        onSaved: (v) => onSaved(v!),
      ),
    );
  }

  Widget buildPasswordField(
    String label,
    Function(String) onSaved,
    bool visible,
    VoidCallback toggle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: !visible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: Colors.teal,
            ),
            onPressed: toggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        validator: (v) => v!.isEmpty ? 'Enter $label' : null,
        onSaved: (v) => onSaved(v!),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        iconEnabledColor: Colors.teal,
        dropdownColor: Colors.white,
        menuMaxHeight: 250,
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            )
            .toList(),
        onChanged: (v) => setState(() => onChanged(v!)),
      ),
    );
  }
}
