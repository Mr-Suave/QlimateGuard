import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'main.dart';

//carbon footprint calculator
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() =>
    _SecondScreenState();
  
}

class _SecondScreenState extends State<SecondScreen> {
  double _distance1 = 0.0, _distance2 = 0.0, _distance3 = 0.0, _distance4 = 0.0;
  String _selectMode1 = 'None', _selectMode2 = 'None', _selectMode3 = 'None', _selectMode4 = 'None';
  double _result = 0.0;

  Map<String, double> _modelFactors = {
    'Sedan/Hatchback Car' : 0.22,
    'Large Car' : 0.27,
    'Train' : 0.06,
    'Airplane' : 0.18,
    'None' : 0.0,
  };

  void _calculateFootprint(){
    _result = _distance1 * (_modelFactors[_selectMode1] ?? 0.0 ) + 
              _distance2 * (_modelFactors[_selectMode2] ?? 0.0 ) + 
              _distance3 * (_modelFactors[_selectMode3] ?? 0.0 ) + 
              _distance4 * (_modelFactors[_selectMode4] ?? 0.0 );
    
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(" "),
        backgroundColor: Colors.black,),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cfbg.png'),
            fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: 
              ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 60.0),

                    //trip 1
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Distance for trip 1(Km)",
                        labelStyle: TextStyle(
                          color: Colors.white
                        )),
                      style: TextStyle(
                        color: Colors.white,
                      ),  
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _distance1 = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text("Select Mode of transport for trip 1: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white),
                      //booyeah
                      ),
                    SizedBox(height:10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButton<String>(
                        value: _selectMode1,
                        isExpanded: true,
                        underline: SizedBox(), //remove 
                        onChanged: (String? newValue){
                          setState(() {
                            _selectMode1 = newValue!;
                          });
                        },
                        items: _modelFactors.keys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0,),
          
                      //trip 2
                      TextField(
                      decoration: const InputDecoration(
                        labelText: "Distance for trip 2(Km)",
                        labelStyle: TextStyle(
                          color: Colors.white
                        )),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _distance2 = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text("Select Mode of transport for trip 2: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white),),
                    SizedBox(height:10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButton<String>(
                        value: _selectMode2,
                        isExpanded: true,
                        underline: SizedBox(), //remove 
                        onChanged: (String? newValue){
                          setState(() {
                            _selectMode2 = newValue!;
                          });
                        },
                        items: _modelFactors.keys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0,),
          
                    //Trip 3
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Distance for trip 3(Km)",
                        labelStyle: TextStyle(
                          color: Colors.white
                        )),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _distance3 = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text("Select Mode of transport for trip 3: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white),),
                    SizedBox(height:10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButton<String>(
                        value: _selectMode3,
                        isExpanded: true,
                        underline: SizedBox(), //remove 
                        onChanged: (String? newValue){
                          setState(() {
                            _selectMode3 = newValue!;
                          });
                        },
                        items: _modelFactors.keys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    //Trip 4
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Distance for trip 4(Km)",
                        labelStyle: TextStyle(
                          color: Colors.white
                        )),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _distance4 = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text("Select Mode of transport for trip 4: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white
                      ),),
                    SizedBox(height:10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButton<String>(
                        value: _selectMode4,
                        isExpanded: true,
                        underline: SizedBox(), //remove 
                        onChanged: (String? newValue){
                          setState(() {
                            _selectMode4 = newValue!;
                          });
                        },
                        items: _modelFactors.keys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0,),
          
                    ElevatedButton(
                      onPressed:(){
                        _calculateFootprint();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(result : _result)), );
                      },
                      child: Text('Calculate Footprint')), 
                  ],
              ),
            )
          ]
        ),
      )
    );
  }
}

//carbonfootprint result screen
class ResultScreen extends StatelessWidget{
  final double result;
  ResultScreen({required this.result});
   Future<String> getMsg() async{
    const apiKey = "AIzaSyBmDlDCNzWM2G2HIsAW5liJBx56FlO4_LY";
    final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
    final content = [Content.text("A person has gone on a trip from one place to another and used vehicles causing a total emission of $result kg of Co2, as calculated in the carbon footprint. Now, provide insights on how safe or harmful this is to the enviornment and provide methods to reduce emissions, the analysis should be very brief and short. Hardly 30 words. Dont provide any text formatting, just plaintext is fine.")];
    final response = await model.generateContent(content);
    String quote = response.text!;
    return quote;
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Estimated Carbon Footprint:',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              ),
              SizedBox(height: 20.0,),
              Text(
                '${result.toStringAsFixed(2)} kg CO2',
                style: TextStyle(
                  fontSize: 32, 
                  color: Colors.green),
              ),
              SizedBox(height: 40.0),
              Text(
                "Analysis: ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                SizedBox(height: 30,),
                 FutureBuilder<String>(
              future: getMsg(), // The asynchronous function
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loader while waiting
                } else if (snapshot.hasError) {
                  return Text(
                    ' Something Went wrong :// Check your internet connection and get back. ',
                    
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  );
                  print(snapshot.error.toString()); // Display an error message
                } else if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                  } else{ 
                    return Text("");
                    }
                  },
                 ),
                 SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text('Back')),
            ]
          ),)
        )
        
    );
  }
}

