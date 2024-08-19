import 'package:flutter/material.dart';
import './SOSPage.dart';
import './SignInPage.dart';
import './homeLoginPage.dart';
import './loginPage.dart';
import './main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 8),)..repeat();
    _alignmentAnimation=Tween<Alignment>(begin: Alignment.topLeft,end: Alignment.bottomRight,).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children:[
          //background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/helpinghandsbg.png"),fit: BoxFit.cover),
              
            ),
          ),
           Scaffold(
            backgroundColor: Colors.transparent,
          appBar:  AppBar(
            backgroundColor: Colors.blue[200],
            title:  Center(
              child: AnimatedBuilder(
                animation: _animationController,
            builder: (BuildContext context,Widget? child){
              return ShaderMask(shaderCallback: (bounds){
                return LinearGradient(colors:const  [Colors.orange,Colors.white,Colors.blue,Colors.white,Colors.green],
                begin: _alignmentAnimation.value,
                end: Alignment.bottomRight,).createShader(bounds);
              },
              child: const Text("Helping Hands",
            style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 30,
            ),
            ),
            );
            },),
          )
        ),
        body:  Padding(
          padding: const EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            child: Column(
              children: [
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Helping Hands is a volunteer management platform designed to mobilize community support in the wake of natural disasters. #QlimateGuard",
                    style: TextStyle(fontSize: 17),),
                  ),
                ),
                const SizedBox(height: 350,),
                Center(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) =>  HomeLoginPage()));
                  }, 
                  child: const Text("Login",style: TextStyle(fontSize: 30,color: Colors.orange),),),
                ),
                const SizedBox(height: 20,),
                
                Center(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SigninPage()));
                  }, child: Text("Register",style: TextStyle(fontSize: 30,color: Colors.blue[200]),),),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>  SOSPage()));
                  }, 
                  child: const Text("HelpBot",style: TextStyle(fontSize: 30,color: Colors.green),),),
                ),
                
              ],
            ),
          ),
        ),
        ),
        ]
      ),
    );
  }
}