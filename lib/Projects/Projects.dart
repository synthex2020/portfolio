import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/NavBar/NavigationBar.dart';
import 'package:portfolio/Projects/ProjectDescription.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  String name, duration, languages, description;
  List list = [];
  List projects = [];

  getData () async{
    Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection('projects').get();
  }//end get data

  Widget createProjectCard(String name, String url, String description, String duration, String languages, ProjectsObject object) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: NetworkImage(url)),
          Text("Name: $name" ,style: TextStyle(color: Colors.black),),
          Text("Languages used: $languages" ,style: TextStyle(color: Colors.black),),
          Text("Duration: $duration" ,style: TextStyle(color: Colors.black),),
          Text("Description: $description" ,style: TextStyle(color: Colors.black),maxLines: 3, overflow: TextOverflow.ellipsis,),
          ElevatedButton(
              onPressed: () {
                //go to relevant page
                Navigator.pushNamed(context,
                    '/projectDescription',
                  arguments: object
                );
              },
            child: Text("View details" , style: TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }//end create project card
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Projects" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(selectedIndex: 3,),
      body: Padding(padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.black),),);
              }//end if

              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                documents.forEach((element) {
                  element.data().forEach((key, value) {
                    if (key == 'description') {
                      description = value;
                    }else if (key == 'duration'){
                      duration = value;
                    }else if (key == 'languages'){
                      languages = value;
                    }else if (key == 'name'){
                      name = value;
                    }else{
                      //pictures
                      list = value;
                    }//end if-else
                  });
                  //add to the list projects here
                  projects.clear();
                  projects.add(
                    new ProjectsObject(
                      list: list,
                      name: name,
                      description: description,
                      languages: languages,
                      duration: duration
                    )
                  );
                });
                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context,  index) {
                    return createProjectCard(projects[index].name,projects[index].list[0],
                        projects[index].description, projects[index].duration, projects[index].languages, projects[index]);
                  },
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }//end if-else
            }else{
              return Center(child: CircularProgressIndicator(),);
            }//end if-else
          },
        )
      ),
    );
  }
}

class ProjectsObject {
  String name, duration, languages, description;
  List list;

  ProjectsObject({this.list, this.duration, this.description, this.languages, this.name});
}//end projects object
