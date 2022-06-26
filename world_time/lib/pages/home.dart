// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    String bgimage = data['isdaytime']
        ? '${data['location']}day.png'
        : '${data['location']}night.png';

    Color bgcolor = data['isdaytime'] ? Colors.blue : Colors.indigo;
    //print(data);
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgimage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
          child: Column(
            children: [
              FlatButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');

                  if (result != null) {
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isdaytime': result['isdaytime'],
                        'flag': result['flag']
                      };
                    });
                  }
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
                label: Text(
                  'Change location',
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 66.0,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
