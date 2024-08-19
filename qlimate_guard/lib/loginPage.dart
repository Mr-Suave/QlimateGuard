import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './AdminPage.dart';
import './SignInPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  
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
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          
          backgroundColor: Colors.orange[400],
        ),
      ),
      backgroundColor: Colors.orange[400],
      body: Column(
        children: [
          Container(
            color: Colors.orange[400],
            width: double.infinity,
            
            height: 260,
            child: const Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),
                  Text('Admin Login',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
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
                                        const Text("AdminID",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.name,
                                          controller: _usernameController,
                                           validator: (value){
                                            if(value==null || value.isEmpty){
                                              return 'Please enter your admin id';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "AdminID",
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        const Text("Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.visiblePassword,
                                          obscureText: visiblePassword1,
                                          controller: _passwordController,
                                           validator: (value){
                                            if(value==null || value.isEmpty){
                                              return 'Please enter your password';
                                            }
                                            return null;
                                          },
                                          decoration:  InputDecoration(
                                            suffixIcon: IconButton(onPressed: (){
                                              setState(() {
                                                visiblePassword1=!visiblePassword1;
                                              });
                                            },
                                             icon: Icon(!visiblePassword1? Icons.visibility:Icons.visibility_off)),
                                            border:  const OutlineInputBorder(),
                                            hintText: "Password",
                                            hintStyle: const TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        ElevatedButton(onPressed: () async{
                                          if(_formKey.currentState!.validate()){
                                            try{
                                            QuerySnapshot loginDetails= await FirebaseFirestore.instance
                                            .collection('admins')
                                            .where('AdminID', isEqualTo: _usernameController.text.trim())
                                            .where('Password',isEqualTo: _passwordController.text.trim())
                                            .get();
                                          
                                            if(loginDetails.docs.isNotEmpty){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Login successful")),
                                              );
                                              String _uname=_usernameController.text;
                                              Navigator.push(context, 
                                              MaterialPageRoute(builder: (context)=>  AdminPage(username: _uname)),);
                                              _usernameController.clear();
                                              _passwordController.clear();
                                            }
                                            else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Incorrect admin id or Password")),
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