import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:qlimate_guard/volunteer.dart';
import 'carbon_footprint.dart';
import 'get_help.dart';
import 'aqi_calculator.dart';
import 'weather.dart';
import 'volunteer.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplaschScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getMsg() async{
    const apiKey = "AIzaSyBmDlDCNzWM2G2HIsAW5liJBx56FlO4_LY";
    final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
    final content = [Content.text("Give a one line quote on climate awareness, safety, disaster management, the quote should be consise and attractive. Dont format it, just give plaintext enclosed in double quotes")];
    final response = await model.generateContent(content);
    String quote = response.text!;
    return quote;
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/homepage.png',
              width: 500,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 500,
              height: 410,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0), 
                children: [
                  buildImage(context, 'assets/aqi.png',1 ),
                  buildImage(context, 'assets/cf.png',2 ),
                  buildImage(context, 'assets/help.png',3 ),
                  buildImage(context, 'assets/weather.png',4 ),
                ],),),
                SizedBox(
                  width: 380,
                  height: 180,
                  child: InkWell(
                      splashColor: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/Volunteer.png'),
                            fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(8.0)),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Volunteer()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
                 FutureBuilder<String>(
              future: getMsg(), // The asynchronous function
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loader while waiting
                } else if (snapshot.hasError) {
                  return Text(
                    '',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ); // Display an error message
                } else if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  );
                  } else{ 
                    return Text("");
                    }
                  },
                 ),
          ]
          ,
        ),)
    );
  }
  
}



Widget buildImage(BuildContext context, String imagePath, int index){

  return InkWell(
    onTap: (){
      //handling button tap
      
      // Navigate to different screens based on button press
        switch (index) {
          case 1:
            print("Button $index tapped!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstScreen()),
            );
            break;
          case 2:
            print("Button $index tapped!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
            break;
          case 3:
            print("Button $index tapped!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdScreen()),
            );
            break;
          case 4:
            print("Button $index tapped!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FourthScreen()),
            );
            break;
        }
    },
    splashColor: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(8.0),
    child: Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,),
          borderRadius: BorderRadius.circular(8.0)),
    )
  );
}







