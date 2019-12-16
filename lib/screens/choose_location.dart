import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  Widget build(BuildContext context) {
    // The list of locations to be shown on choose location screen
    List<WorldTime> locations = [ // list of type WorldTime object
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Asia/Kolkata', location: 'Mumbai', flag: 'india.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_koria.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    ];
    print(locations);


    void updateTime(index) async {
      // getting the currentTime instance object based on received index
      // from listTile tap
      WorldTime currentTime = locations[index];
      // since we are making request to the api, hence needs await
      await currentTime.getTime();
      // once we got the response from WorldTime service, navigate to home screen
      Navigator.pop(context,{ // elements to be sent to the next screen
        'location': currentTime.location,
        'flag': currentTime.flag,
        'time': currentTime.time,
        'isDaytime': currentTime.isDaytime,
        'date': currentTime.date,
      });
      // continue to home screen
    }
    print("build function ran");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0, //remove drop shadow
      ),
      // ListView helps to display all the items of a list in List Format
      body: ListView.builder(
          itemCount: locations.length,
          // itemBuilder property builds list format with given elements of a list
          // it iterates through the list of locations object
          itemBuilder: (context, index){ // index is the counter based on itemCount
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
             child: Card(
               color: Colors.grey[100],
               child: ListTile(
                 //onTap event
                 onTap: (){
                   //send the currently tapped listTile index value
                   updateTime(index);
                 },
                 // list title
                 title: Text(locations[index].location),
                 // list icon
                 leading: CircleAvatar(
                   backgroundImage: AssetImage('assets/images/flags/${locations[index].flag}'),
                 ),
               )
             ),
           );
          }
      )
    );
  }
}
