# portfolio

An applicaton that allows for developers to showcase their work. It takes advantage of a firebase backend and the data is organazied and structured in the following way: 
  Collection : education
  Document feilds: duration (string), location (string), program (string), school (string)
  Collection : job_experiences
  Document feilds: comapny (string), description (string), duration (string), positon (string)
  Collection : volunteer_experiences
  Document feilds: description (string), duration (string), organazation (string), position (string)
  Collection: projects
  Document feilds: description (string), duration (string), languages (string), name (string), pictures (List/array <string> urls)
  Collection: skills
  Document feilds: description (string), name (string)
  
The application source code is tightly coupled with the above structure. 
To modify application to fit one's personal profile:
      1.Add the application to the relevent firebase project
      2.Add the relevent google firebase file to the relevent part of the project, the google json file that is recieved when regestering an app
      3.Add links to your own personal social media in the about page, under the on pressed function button

You are free to edit everything that is the source code as you see fit in accordance with your own portfolio. 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
