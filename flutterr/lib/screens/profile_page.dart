import 'package:flutter/material.dart';
import 'tasks_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _UserProfileState();
}

class _UserProfileState extends State<ProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "Hello Khalil Nasreddine",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 25)
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TasksPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.task))
          ],
        ),
        body: const Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/me.png'),
                    radius: 150,
                  ),
                  SizedBox(height: 20,),
                  Text('Khalil Nasreddine', style: TextStyle(fontSize: 25),)
                ],
              ),
            )
          ],
        )
    );
  }
}