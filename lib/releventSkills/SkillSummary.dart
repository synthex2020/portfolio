import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/NavBar/NavigationBar.dart';

class SkillSummary extends StatefulWidget {
  @override
  _SkillSummaryState createState() => _SkillSummaryState();
}

class _SkillSummaryState extends State<SkillSummary> {

  String skill, description;
  List list = [];
  getData () async {
    Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection('skills').get();
  }//end get data

  Widget createSkillsSummary(String skill, String shortDescription) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Column(
        children: [
          Row(
            children: [
              Text("Skill set: $skill" , style: TextStyle(color: Colors.black),),
            ],
          ),
          Text("Skill description: \n$shortDescription" , style: TextStyle(color: Colors.black),),
          Divider()

        ],
      ),
    );
  }//end create skill summary
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skill Summary" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(selectedIndex: 2,),
      body: Padding(padding: EdgeInsets.all(10), child: SingleChildScrollView(
        child: Column(
          children: [
            Icon(Icons.settings, size: 230,),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasError)
                      return Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.black),),);

                    if(snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                      documents.forEach((element) {
                        element.data().forEach((key, value) {
                          if (key == 'name'){
                            skill = value;
                          }else{
                            //description
                            description = value;
                          }//end if - else
                        });
                        //add to list here
                        list.clear();
                        list.add(
                          new Data(description: description, skill: skill)
                        );
                      });
                      return Container(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return createSkillsSummary(list[index].skill, list[index].description);
                          },
                        ),
                        height: MediaQuery.of(context).size.height,
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }//end if-else
                  }else {
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


class Data {
  String skill, description;

  Data({this.description, this.skill});
}