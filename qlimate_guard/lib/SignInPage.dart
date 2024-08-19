import 'package:flutter/material.dart';
import './VolunteerLogin.dart';
import './loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './voulunteer_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _fnameController=TextEditingController();
  final TextEditingController _lnameController=TextEditingController();
  final TextEditingController _contactNumController=TextEditingController();
  final TextEditingController _cityController=TextEditingController();
  final TextEditingController _ageController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  bool? isChecked=false;
  bool visiblePassword1=false;

  
  @override
  void initState() {
    super.initState();
  }

  
  
  Future<void> _saveToDatabase() async{
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(_contactNumController.text);

    await userDoc.set({
      'Username': _usernameController.text,
      'First Name': _fnameController.text,
      'Last Name': _lnameController.text,
      'Contact Number':_contactNumController.text,
      'City':_cityController.text,
      'Age':_ageController.text,
      },SetOptions(merge: true));
  }
  @override
  void dispose() {
    super.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _contactNumController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _usernameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
      ),
      backgroundColor: Colors.blue[200],
      body: Column(
        children: [
          Container(
            color: Colors.blue[200],
            width: double.infinity,
            
            height: 270,
            child: const Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text('Volunteer Registration',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 8,),
                  Text("Welcome to Helping Hands",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
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
                                        const Text("First Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        
                                        TextFormField(
                                          style:const  TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _fnameController,
                                          validator: (value) {
                                              if (value==null ||value.isEmpty ) {
                                                return 'Please enter your first name';
                                              }
                                              return null;
                                            },
                                          decoration:const  InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "First Name",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const Text("Last Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style:const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _lnameController,
                                           validator: (value) {
                                              if (value==null || value.isEmpty ) {
                                                return 'Please enter your last name';
                                              }
                                              return null;
                                            },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Last Name",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const Text("Contact Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: _contactNumController,
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
                                        const Text("City",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style:const  TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _cityController,
                                          validator: (value){
                                            if(value==null || value.isEmpty){
                                              return 'Please enter your city name';
                                            }
                                            return null;
                                          },
                                          decoration:const  InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "City",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const Text("Age",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style:const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.number,
                                          controller: _ageController,
                                           validator: (value){
                                            if(value==null || value.isEmpty){
                                              return 'Please enter your age';
                                            }
                                            if(int.tryParse(value)==null || int.tryParse(value)!<18 || int.tryParse(value)!>60){
                                              return 'Your age must be between 18 and 60';
                                            }
                                            return null;
                                          },
                                          decoration:const  InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Age",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const Text("Username",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        
                                        TextFormField(
                                          style:const  TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _usernameController,
                                          validator: (value) {
                                              if (value==null ||value.isEmpty ) {
                                                return 'Please enter your username';
                                              }
                                              return null;
                                            },
                                          decoration:const  InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Username",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        ElevatedButton(onPressed: (){
                                          if(_formKey.currentState!.validate()){
                                            showDialog(
                                              
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                
                                                  title:
                                                  const Row(
                                                    
                                                    children: [
                                                      Icon(Icons.check_box),
                                                      SizedBox(width: 8,),
                                                      Expanded(child: Text('''Please read the details and tick the checkbox!''',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                                                    ],
                                                  ),
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext context,StateSetter setState){
                                                    return SizedBox(
                                                      height: 450,
                                                      child: Column(
                                                        children: [
                                                           const Expanded(
                                                             child:  Text(
                                                                '''-> Our platform is a tool to connect volunteers with causes they care about. It's essential to remember that volunteers are responsible for their own safety and well-being while participating in volunteer activities.
                                                             -> We are not liable for any accidents or injuries incurred during volunteer activities.
                                                             -> Do not misuse this platform and just use it to help others and seek help from others during natural disasters.
                                                             -> We recommend you not to take part in volunteering activities if you have some serious health issues.'''),
                                                           ),
                                                               const SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Checkbox(value: isChecked, onChanged: (bool?value){
                                                                setState(() {
                                                      
                                                                  isChecked =value;
                                                                });
                                                                
                                                              },),
                                                              const Expanded(child: Text("I agree to the terms and conditions"),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );},
                                                  ),
                                                               
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async{
                                                        if(isChecked==true){
                                                          try{
                                                            //check if user exists
                                                            QuerySnapshot contactSnapshot = await FirebaseFirestore.instance
                                                            .collection('users')
                                                            .where('Contact Number',isEqualTo: _contactNumController.text)
                                                            .get();

                                                      
                                                            if(contactSnapshot.size>0 ){
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(content: Text('Already registered!')),
                                                              );
                                                              return;
                                                            }
                                                            //store in firestore
                                                            

                                                            await _saveToDatabase();
                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful!')));
                                                            String _uname=_usernameController.text;
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  VoulunteerPage(username: _uname)));
                                                            _fnameController.clear();
                                                            _lnameController.clear();
                                                            _contactNumController.clear();
                                                            _cityController.clear();
                                                            _ageController.clear();
                                                            _usernameController.clear();
                                                          }catch (e){
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Error registering')),
                                                            );
                                                          }
                                                         }
                                                
                                                      },
                                                      child: const Text('Register'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },                                      
                                        child: const Center(child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                                        const SizedBox(height: 16,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text('Already has an account? ',style: TextStyle(color: Colors.black),),
                                            TextButton(onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Volunteerlogin()));
                                            }, child:const  Text('Login',style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))    
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