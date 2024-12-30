import 'package:barcode_widget/barcode_widget.dart';
import 'package:delivery_man/const/my_color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BarcodeScreen extends StatelessWidget {
  BarcodeScreen({Key? key}) : super(key: key);
  //
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Generate Barcode'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: myColor.themeColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarcodeWidget(
                      width: 200,
                      height: 200,
                      data: controller.text,
                      barcode: Barcode.code128()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
