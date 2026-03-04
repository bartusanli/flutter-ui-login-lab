import 'package:flutter/material.dart';

class DirectoryScreen extends StatelessWidget {  final List<Map<String, String>> users;
const DirectoryScreen({super.key, required this.users});

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
          subtitle: Text(users[index]["email"]!),
          trailing: const Icon(Icons.mail_outline, color: Colors.indigo),
          onTap: () {},
        ),
      );
    },
  );
}
}