import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/NavBar/NavigationBar.dart';


class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {

  List education = [];
  String duration, location, program, school;
  Widget createEducationCard(String placeOfLearning, String level, String location, String duration) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: Text("$level", style: TextStyle(color: Colors.black),)),
              Expanded(child: Text("$duration", style: TextStyle(color: Colors.black),)),

            ],
          ),
          Text("$placeOfLearning" , style: TextStyle(color: Colors.black),),
          Text("$location" , style: TextStyle(color: Colors.black),),

        ],
      ),
    );
  }//end create education card
  
  getData () async {
    Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection('education').get();
  }//end get data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Education" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(selectedIndex: 1,),
      body: Padding(padding: EdgeInsets.all(10),child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.my_library_books, size: 230,),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.black),),);
                    }

                    if(snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                      documents.forEach((element) {
                        element.data().forEach((key, value) {
                          if (key == 'duration') {
                            duration = value;
                          }else if (key == 'location'){
                            location = value;
                          }else if (key == 'program'){
                            program = value;
                          }else{
                            //school
                            school = value;
                          }//end if-else
                        });
                        //this is where we add to our list
                        education.add(
                          new EducationObject(
                            duration: duration,
                            location: location,
                            school: school,
                            program: program
                          )
                        );
                      });
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: education.length,
                          itemBuilder: (context , index) {
                            return createEducationCard(education[index].school, education[index].program, education[index].location, education[index].duration);
                          },
                        ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }//end if-else
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }//end if-else
                }
            ),
          ],
        ),
      ),),
    );
  }
}

class EducationObject {
  String location, school, program, duration;

  EducationObject({this.duration, this.location, this.program, this.school});
}
