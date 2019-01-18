import 'package:flutter/material.dart';
import 'package:photo_search_app/searched_image.dart';

void main()=>runApp(new LandingPage());

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  var _controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Material(
          color: Colors.white,
          child: new Center(
            child: new ListView(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(32.0)),
                new Image.asset(
                    'images/flutter_reg.jpeg',
                     width: 100.0,
                     height: 100.0,
                ),
                new SizedBox(height: 5.0,),
                new Center(
                  child: new Text(
                    'PiQue',
                    style:new TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                new SizedBox(height: 10.0,),
                new ListTile(
                  title: new TextFormField(
                    controller: _controller,
                    decoration: new InputDecoration(
                      labelText: "Enter a Category",
                      hintText: "eg. apples,forest,tiger",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.all(18.0),
                    ) ,
                  ),
                ),
                new SizedBox(height: 10.0,),
                new ListTile(
                  title: new Material(
                    shadowColor: Colors.black54,
                    color: Colors.lightBlue,
                    elevation: 5.0,
                    borderRadius: new BorderRadius.circular(15.0),
                    child: new MaterialButton(
                        height: 40.0,
                        onPressed: (){
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context)=> new SearchedImage(
                                  //passing the category of image
                                  category: _controller.text,
                                ),
                            )
                          );
                        },
                      child: new Text(
                        "Search",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

