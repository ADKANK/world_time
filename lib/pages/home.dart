import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {  };


  @override
  void initState() {
    super.initState(); 
    print("Home page ... ");
  }

  @override
  Widget build(BuildContext context) {
      data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    String? bgImage = data['isDayTime'] ? "day.png" : "night.png";
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];
    print(data);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/${bgImage}'),
              fit : BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0,120.0,0.0,0.0),
            child: Column(
                children: <Widget>[

                  ElevatedButton.icon(
                      onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {


                    data = {
                    'time' : result['time'],
                    'location' : result['location'],
                    'isDayTime' : result['isDayTime'],
                    'flag' : result['flag'],
                    };
                    });
                    },


                      icon: Icon(Icons.edit_location,
                      color: Colors.grey[400]),
                      label: Text(
                          "Edit Location",
                          style: TextStyle(
                            color: Colors.grey[400],

                          ) ),

                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data['time'],
                        style: TextStyle(
                          fontSize: 70.0,
                          color: Colors.white,

                        ),
                      )
                    ],
                  )

                  ],
                  ),
          ),
        )

        ),


    );
  }
}
