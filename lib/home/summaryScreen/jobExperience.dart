import 'package:flutter/material.dart';
import 'package:portfolio/home/summaryScreen/Summary.dart';

class JobExperience extends StatefulWidget {
  @override
  _JobExperienceState createState() => _JobExperienceState();
}

class _JobExperienceState extends State<JobExperience> {


  Widget createExperienceCard(String position, String company, String duration, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Position $position" , style: TextStyle(color: Colors.black),),
          Text("Company $company" , style: TextStyle(color: Colors.black),),
          Text("Duration $duration" , style: TextStyle(color: Colors.black),),
          Divider(),
          Text("Description:\n$description", style: TextStyle(color: Colors.black),),
          Divider()

        ],
      ),
    );
  }//end experience card
  @override
  Widget build(BuildContext context) {
    final JobExperienceObject object  = ModalRoute.of(context).settings.arguments;

    final String position = object.position;
    final String company = object.company;
    final String duration = object.duration;
    final String description = object.description;

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Experiences" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.all(10), child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return createExperienceCard(position, company, duration, description);
        },
      ),),
    );
  }
}
