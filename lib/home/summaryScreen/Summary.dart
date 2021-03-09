import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/NavBar/NavigationBar.dart';
import 'package:portfolio/home/summaryScreen/about.dart';
import 'package:portfolio/home/summaryScreen/jobExperience.dart';
import 'package:portfolio/home/summaryScreen/volunteerExperience.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  String company, descriptionJobExperience, durationJob, positionJob;
  String org, description, duration, position;
  List jobExperience = [];
  List volunteerExperience = [];

  Widget createWorkExperienceCard(String nameOfCompany, String nameOfPosition, String duration, JobExperienceObject object) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Column(
        children: [
          Text("Name of Company: $nameOfCompany" , style: TextStyle(color: Colors.black),),
          Text("Name of position: $nameOfPosition" , style: TextStyle(color: Colors.black),),
          Text("Duration of work term: $duration" , style: TextStyle(color: Colors.black),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("View more in detail", style: TextStyle(color: Colors.black),),
                color: Colors.blueGrey,
                onPressed: () {
                  //go to the relevant page
                 Navigator.pushNamed(
                     context,
                     '/jobExperience',
                   arguments: object
                 );
                },
              ))
            ],
          )

        ],
      ),
    );
  }//end work experience card

  Widget createVolunteerExperienceCard(String nameOfOrg, String nameOfPosition, String duration, VolunteerExperienceObject object) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Column(
        children: [
          Text("Name of Organization: $nameOfOrg" , style: TextStyle(color: Colors.black),),
          Text("Name of position: $nameOfPosition" , style: TextStyle(color: Colors.black),),
          Text("Duration: $duration" , style: TextStyle(color: Colors.black),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("View more in detail", style: TextStyle(color: Colors.black),),
                color: Colors.blueGrey,
                onPressed: () {
                  //go to the relevant page
                  Navigator.pushNamed(
                      context,
                      '/volunteerExperience',
                    arguments: object
                  );
                },
              ))
            ],
          )

        ],
      ),
    );
  }//end card
  
  getExperienceData() async {
    Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection('job_experiences').get();
  }//end get experience data
  
  getVolunteerData() async {
    Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection('volunteer_experiences').get();
  }//end get volunteer data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(icon:Icon(Icons.info_outline), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));}),
            ],
          )
        ],
        title: Text("Summary" , style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: NavigationBar(selectedIndex: 0,),
      body: Padding(padding: EdgeInsets.all(10), child: Container(
          //this first list view is for work experience
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("https://www.autokey.ie/wp-content/uploads/2015/01/no-profie-image.gif"),
                  maxRadius: 150,
                ),
                //for work experience
                FutureBuilder(
                    future: getExperienceData(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasData){
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                          documents.forEach((element) {
                            element.data().forEach((key, value) {
                              if (key == 'company'){
                                company = value;
                              }else if (key == 'description'){
                                descriptionJobExperience = value;
                              }else if (key == 'duration'){
                                durationJob = value;
                              }else{
                                //position
                                positionJob = value;
                              }//end if-else
                            });
                            //add list elements here
                            jobExperience.clear();
                            jobExperience.add(
                              JobExperienceObject(
                                company: company,
                                duration: durationJob,
                                description: descriptionJobExperience,
                                position: positionJob
                              )
                            );
                          });
                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context , index) {
                              return createWorkExperienceCard(jobExperience[index].company, jobExperience[index].position, jobExperience[index].duration,jobExperience[index]);
                            },
                            itemCount: jobExperience.length,
                          );
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }//end if-else

                        if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.black),),);
                        }
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    }
                ),
                //for volunteer experience
                FutureBuilder(
                    future: getExperienceData(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasData){
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                          documents.forEach((element) {
                            element.data().forEach((key, value) {
                              if (key == 'organization'){
                                org= value;
                              }else if (key == 'description'){
                                description = value;
                              }else if (key == 'duration'){
                                duration = value;
                              }else{
                                //position
                                position = value;
                              }//end if-else
                            });
                            //add list elements here
                            volunteerExperience.clear();
                            volunteerExperience.add(
                                VolunteerExperienceObject(
                                    org: org,
                                    duration: duration,
                                    description: description,
                                    position: position
                                )
                            );
                          });
                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context , index) {
                              return createVolunteerExperienceCard(volunteerExperience[index].org, volunteerExperience[index].position, volunteerExperience[index].duration, volunteerExperience[index]);
                            },
                            itemCount: volunteerExperience.length,
                          );
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }//end if-else

                        if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.black),),);
                        }
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    }
                ),
                //the socials
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JobExperienceObject {
  String company, description, duration, position;

  JobExperienceObject({this.description, this.duration, this.company, this.position});
}//end experience

class VolunteerExperienceObject {
  String org, description,duration, position;

  VolunteerExperienceObject({this.position, this.duration, this.description, this.org});
}//end volunteer experience
