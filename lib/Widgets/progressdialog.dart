import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  ProgressDialog({Key? key, this.message}) : super(key: key);
  String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow,
      child: Container(
          margin: EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                SizedBox(
                  width: 26,
                ),
                Flexible(
                  child: Text(
                    message!,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
