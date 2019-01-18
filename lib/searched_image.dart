import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_search_app/api_key.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchedImage extends StatefulWidget {

   String category;
  SearchedImage({this.category});

  @override
  _SearchedImageState createState() => new _SearchedImageState();
}

class _SearchedImageState extends State<SearchedImage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: new Text(
            "PiQue",
            style:new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        body:new FutureBuilder(

          //passing the category so that we can fetch the data according to the searched image
          //here we are using widget to access the category variable because category variable declared in stateful widget
            future: getImages(widget.category),
            builder: (context,snapshot){

              Map data=snapshot.data;

              //If some error happened in between fetching the data from the server
              if(snapshot.hasError){
                print(snapshot.error);
                return new Text('Failed to get response from the server');
              }
              /*
               If there are some data then we need to display the image inside the ListView
               */
              else if(snapshot.hasData){
                return new Center(
                  child: new ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        return new Column(
                          children: <Widget>[
                            new Padding(padding: const EdgeInsets.all(5.0)),
                            new Container(
                              child: new InkWell(
                                onTap: (){},
                                child: new Card(
                                  color:Colors.red,
                                  elevation:5.0,
                                  child: new Image.network(
                                      '${data['hits'][index]['webformatURL']}'
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                  ),
                );
              }else if(!snapshot.hasData){

                //if there are no data then we will show the centerIndicator

                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
            }
        ),
      ),
    );
  }
}

Future<Map> getImages(String category)async{

  String url="https://pixabay.com/api/?key=$apiKey&q=$category&image_type=photo&pretty=true";
  http.Response response= await http.get(url);

  return json.decode(response.body);

}
