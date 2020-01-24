import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  Widget child;
  double height ;
  MyCard({@required this.child,this.height = 120});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      margin: EdgeInsets.fromLTRB(25, 35, 25, 0),
      child: Center(
        child: this.child,
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(27.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10.0,
              offset: Offset(-7, -7),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(.075),
              blurRadius: 10.0,
              offset: Offset(7, 7),
            )
          ]),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(Icons.add),
        padding: const EdgeInsets.all(28.0),
        decoration:
            BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(27.0),
                boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10.0,
                offset: Offset(-7, -7),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(.075),
                blurRadius: 10.0,
                offset: Offset(7, 7),
              )
            ]));
  }
}
