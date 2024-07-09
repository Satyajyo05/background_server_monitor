
// for change/reset pin screens

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_code/pinPage.dart';
class DialogHelper {
  Widget createListTile(String text, BuildContext context) {
    return ListTile(
      leading: Text(text, style: TextStyle(fontSize: 18, color: Colors.white),),
      trailing: Icon(Icons.arrow_circle_right_outlined),
      onTap: (){
        showPinDialog(context);
      },
    );
  }

  void showPins(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Dialog(
            backgroundColor: Color(0xFF179F9F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  createListTile("Change Authentication Pin", context),
                  Divider(thickness: 2, color: Colors.white,),
                  createListTile("Change Signing Pin",context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}