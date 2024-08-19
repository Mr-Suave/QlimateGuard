import 'package:flutter/material.dart';
import './VolunteerLogin.dart';
import './loginPage.dart';

class HomeLoginPage extends StatefulWidget {
  const HomeLoginPage({super.key});

  @override
  State<HomeLoginPage> createState() => _HomeLoginPageState();
}

class _HomeLoginPageState extends State<HomeLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
      ),
      backgroundColor: Colors.orange[400],
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }, child: const Text('Admin Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                 Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Volunteerlogin()));
              }, child: const Text('Volunteer Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    );
  }
}