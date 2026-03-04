import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'User Preferences Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const BottomMenu(),
    );
  }
}

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _activePage = 0;

  // Professional data structure: name and email
  final List<Map<String, String>> _savedUsers = [
    {"name": "Emma Richardson", "email": "richemma@mail.com"},
    {"name": "Olivia Perry", "email": "perryolivia@mail.com"},
  ];

  void _addNewUser(String name, String email) {
    setState(() {
      _savedUsers.add({"name": name, "email": email});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ComplexWidgetPage(onSave: _addNewUser),
      PassListPage(users: _savedUsers),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Profile Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_activePage],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activePage,
        onDestinationSelected: (index) => setState(() => _activePage = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_add_alt_1_outlined),
            selectedIcon: Icon(Icons.person_add_alt_1),
            label: "Registration",
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: "Directory",
          ),
        ],
      ),
    );
  }
}

class ComplexWidgetPage extends StatefulWidget {
  final Function(String, String) onSave;
  const ComplexWidgetPage({super.key, required this.onSave});

  @override
  State<ComplexWidgetPage> createState() => _ComplexWidgetPageState();
}

class _ComplexWidgetPageState extends State<ComplexWidgetPage> {
  final _formKey = GlobalKey<FormState>(); // Used for professional validation
  bool _isPremium = false;
  String? _selectedCategory;
  String _gender = 'none';

  final List<String> _categories = ["Home & Furniture", "Electronics", "Clothing", "Supermarket"];

  // Controllers to capture text input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Memory management: clean up controllers when widget is destroyed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSave() {
    // Professional logic: only save if the form is valid
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

      // Reset form
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

            // Membership Toggle
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

            // Personal Info Section
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
                    // NEW EMAIL FIELD
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

            // Gender Selection
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

            // Action Button
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

class PassListPage extends StatelessWidget {
  final List<Map<String, String>> users;
  const PassListPage({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(users[index]["name"]![0]),
            ),
            title: Text(users[index]["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(users[index]["email"]!), // Displays the entered email
            trailing: const Icon(Icons.mail_outline, color: Colors.indigo),
            onTap: () {},
          ),
        );
      },
    );
  }
}