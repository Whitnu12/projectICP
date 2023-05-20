import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //ListView
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20),
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 170,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                ),
                height: 100,
                width: 350,
                margin: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: 'Teknik Komputer Jaringan dan kesehatan ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          overflow: TextOverflow.clip,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(children: const <TextSpan>[
                                  TextSpan(
                                    text: ' XII TKJ 2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("7PM", textAlign: TextAlign.left,
                                  style: TextStyle(
                                    
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Mengajar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: Colors.yellow,
                                  ),
                                ],
                              )
                            ],
                          )))
                    ],
                  ),
                ),
              ),
            ),
          ),
          //end of ListView

        ],
      )),

      
    );
  }
}
