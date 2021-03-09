import 'package:flutter/material.dart';
import 'package:portfolio/Projects/Projects.dart';

class ProjectDescription extends StatefulWidget {
  @override
  _ProjectDescriptionState createState() => _ProjectDescriptionState();
}

class _ProjectDescriptionState extends State<ProjectDescription> {

  List list = [
    "https://play-lh.googleusercontent.com/Wv-CAK90rS3A6OHnHPS52s75N67a8kMszCGr09yX7ettBuU9tKaQ_dBalseGoWRI5w=w1264-h717",
    "https://play-lh.googleusercontent.com/Cxr3-EyUWkA_yf52XgC3hMzdlQZJT4YB1-z1N_zN-fIqY78rNUP7LxCenQVJWDzAsSQ=w1264-h717",
    "https://play-lh.googleusercontent.com/xlwnG4XockhJuKyzBEAM61MxzP3XEVFgtaQoeZqfirZLC451VPNEtg8MPliaD8hF_e78=w1264-h717",
  ];
  Widget createDisplay(List urlList, String name, String duration, String description, String languages, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Project name: $name" , style: TextStyle(color: Colors.black),),
        Text("Languages used: $languages" , style: TextStyle(color: Colors.black),),
        Text("Project duration: $duration" , style: TextStyle(color: Colors.black),),
        Text("Project description: \n$description" , style: TextStyle(color: Colors.black),),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height/2,
          child: ListView.builder(
            itemCount: urlList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Image(image: NetworkImage(urlList[index]));
            },
          ),
        )


      ],
    );
  }//end create display
  @override
  Widget build(BuildContext context) {

    final ProjectsObject object = ModalRoute.of(context).settings.arguments;

    final List urlList = object.list;
    final String name = object.name;
    final String duration = object.duration;
    final String description = object.description;
    final String languages = object.languages;

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Description" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.all(10), child: SingleChildScrollView(
        child: createDisplay(urlList, name, duration, description, languages, context),
      ),),
    );
  }
}
