import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //data list to be initialized before getting response
  Map data = {};
  
  @override
  Widget build(BuildContext context) {
    // getting response from previous screen or last location and
    // assigning same to the data list
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 160.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  // onPressed Event on Edit Location button
                  onPressed: () async {
                    // waiting for the response through choose location screen
                    // since we don't know what type of response result will come,
                    // hence attach dynamic type
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    // To rebuild whole home build widget so that we get new
                    // chosen location data
                    setState(() {
                      data = {
                        'time': result['time'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                        'location': result['location'],
                        'date': result['date']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300]
                    ),
                  )
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['date'],
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 4.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}
