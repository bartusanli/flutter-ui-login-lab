import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final Function(String, String) onSave;
  const RegistrationScreen({super.key, required this.onSave});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPremium = false;
  String? _selectedCategory;
  String _gender = 'none';

  final List<String> _categories = ["Home & Furniture", "Electronics", "Clothing", "Supermarket"];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a Shopping Interest")),
        );
        return;
      }

      widget.onSave(
        "${_firstNameController.text} ${_lastNameController.text}",
        _emailController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Saved Successfully!")),
      );

      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Card(
              child: SwitchListTile(
                secondary: Icon(_isPremium ? Icons.star : Icons.star_border,
                    color: _isPremium ? Colors.amber : null),
                title: const Text("Premium Membership"),
                subtitle: Text(_isPremium ? "Active features enabled" : "Standard access"),
                value: _isPremium,
                onChanged: (val) => setState(() => _isPremium = val),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        hintText: "example@mail.com",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter an email';
                        if (!value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Shopping Interest",
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedCategory,
                      items: _categories.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Demographics", style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text("Woman"),
                    value: 'woman',
                    groupValue: _gender,
                    onChanged: (val) => setState(() => _gender = val.toString()),
                  ),
                  RadioListTile(
                    title: const Text("Man"),
                    value: 'man',
                    groupValue: _gender,
                    onChanged: (val) => setState(() => _gender = val.toString()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: _handleSave,
                icon: const Icon(Icons.save),
                label: const Text("SAVE USER", style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Register New User",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
        ),
        const Text(
          "Add contact details to the central directory.",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}