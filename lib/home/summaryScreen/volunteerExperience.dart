import 'package:flutter/material.dart';
import 'package:portfolio/home/summaryScreen/Summary.dart';

class VolunteerExperience extends StatefulWidget {
  @override
  _VolunteerExperienceState createState() => _VolunteerExperienceState();
}

class _VolunteerExperienceState extends State<VolunteerExperience> {

  Widget createVolunteerExperience(String position, String org, String duration, String description){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Position $position" , style: TextStyle(color: Colors.black),),
          Text("Organization $org" , style: TextStyle(color: Colors.black),),
          Text("Duration $duration" , style: TextStyle(color: Colors.black),),
          Divider(),
          Text("Description:\n$description", style: TextStyle(color: Colors.black),),
          Divider()

        ],
      ),
    );
  }//end create volunteer experience
  @override
  Widget build(BuildContext context) {


    final VolunteerExperienceObject object  = ModalRoute.of(context).settings.arguments;

    final String position = object.position;
    final String organization = object.org;
    final String duration = object.duration;
    final String description = object.description;

    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer Experience" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.all(10), child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return createVolunteerExperience(position, organization, duration, description);
        },
      ),),
    );
  }
}
