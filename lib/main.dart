import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hirebus Coupon Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    //   getData();
  }

  IconData selected = Icons.add_circle_outline;
  var coupons = [];
  bool _value = false;
  String selectedcouponid;
  Future<List> getData() async {
    coupons=[];
    var data = await http
        .post("https://hirebus-backend.herokuapp.com/admin/getPublicCoupons");
 
    print("aaya");
  //  var data = await http.get("http://192.168.1.41/jsondata");
    var jsonData = json.decode(data.body);
    print(jsonData.length);
    print(jsonData["coupons"].length);
    //print(jsonData["coupons"][0]["couponCode"]);
    print("hiiiiiii");
    // List<Coupons> users = [];
    var j;
    for (var i = 0; i <jsonData["coupons"].length; i++) {
      j = Coupons();
      j.discount = jsonData["coupons"][i]["discount"];
      j.couponDescription = jsonData["coupons"][i]["couponDescription"];
      j.enability = jsonData["coupons"][i]["enability"];
      j.id = jsonData["coupons"][i]["_id"];
      j.couponCode = jsonData["coupons"][i]["couponCode"];
      coupons.add(j);
print(coupons.length);
      print(coupons[i].couponCode);
    }
    print(coupons.length);
 
  return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      /*  body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) => Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: Text(coupons[0].couponCode),
                        subtitle: Text(coupons[0].couponCode),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )) */
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot
                  .hasData
              ? Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: coupons.length,
                            itemBuilder: (context, index) {
                              final coupons1 = coupons[index];

                              return ListTile(
                                title: Text(coupons1.couponCode,
                                
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Container(
                                    child: Column(
                                  children: [
                                    Text(
                                        "Description: ${coupons1.couponDescription}",
                                        style: TextStyle(color: Colors.green)),
                                    Text(
                                      "Click to apply",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                )),
                                autofocus: false,
                                selected: _value,
                                minVerticalPadding: 10,
                                onTap: () {
                                  print(coupons1.id);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

class Coupons {
  int discount;
  String couponDescription;
  bool enability;
  String id;
  String couponCode;

  // Coupons(this.discount, this.couponDescription, this.enability, this.id,
  //     this.couponCode);
}
