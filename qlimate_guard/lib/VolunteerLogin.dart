import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './AdminPage.dart';
import './SignInPage.dart';
import './voulunteer_page.dart';

class Volunteerlogin extends StatefulWidget {
  const Volunteerlogin({super.key});

  @override
  State<Volunteerlogin> createState() => _VolunteerloginState();
}

class _VolunteerloginState extends State<Volunteerlogin> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _contactnumController=TextEditingController();
  
  bool? isChecked=false;
  bool visiblePassword1=true;
  bool visiblePassword2=false;

  
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _contactnumController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
      ),
      backgroundColor: Colors.orange[400],
      body: Column(
        children: [
          Container(
            color: Colors.orange[400],
            width: double.infinity,
            
            height: 250,
            child: const Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),
                  Text('Volunteer login',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 8,),
                  Text("Welcome mate!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
              ),
                    
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:  SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20,),
                                        const Text("Username",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _usernameController,
                                           validator: (value){
                                            if(value==null || value.isEmpty){
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Username",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                       const Text("Contact Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: _contactnumController,
                                           validator: (value) {
                                              if (value==null || value.isEmpty ) {
                                                return 'Please enter your contact number';
                                              }
                                              if(!RegExp(r'^\d{10}$').hasMatch(value)){
                                                return 'Please enter a valid contact number';
                                              }
                                              return null;
                                            },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Contact Number",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const SizedBox(height: 16,),
                                        ElevatedButton(onPressed: () async{
                                          if(_formKey.currentState!.validate()){
                                            try{
                                            QuerySnapshot loginDetails= await FirebaseFirestore.instance
                                            .collection('users')
                                            .where('Username', isEqualTo: _usernameController.text.trim())
                                            .where('Contact Number',isEqualTo: _contactnumController.text.trim())
                                            .get();
                                            print('Username: ${_usernameController.text.trim()}');
                                            print('Contact Number: ${_contactnumController.text}');
                                            print('Query Snapshot: ${loginDetails.docs.length}');
                                            
                                            if(loginDetails.docs.isNotEmpty){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Login successful")),
                                              );
                                              String _uname=_usernameController.text;
                                              Navigator.push(context, 
                                              MaterialPageRoute(builder: (context)=>  VoulunteerPage(username: _uname)),);
                                              _usernameController.clear();
                                              _contactnumController.clear();
                                            }
                                            else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Incorrect username or contact number")),
                                              );
                                            }
                                            }catch (e){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Error logging in '),)
                                              );
                                            }                                       
                                            }
                                        },                                      
                                        child: const Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),),
                                        const SizedBox(height: 16,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black),),
                                            TextButton(onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninPage()));
                                            }, child:const  Text('Sign-in',style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline),))    
                                          ],
                                        )
                                      ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      
    );
  }
}