import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UpdateProductsDetails extends StatefulWidget {
  final dynamic name;
  final dynamic qty;
  const UpdateProductsDetails(
      {super.key, required this.name, required this.qty});

  @override
  State<UpdateProductsDetails> createState() => _UpdateProductsDetailsState();
}

class _UpdateProductsDetailsState extends State<UpdateProductsDetails> {
  TextEditingController productnamecontroller = TextEditingController();
  final productquantitycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    productnamecontroller.text = widget.name;
    productquantitycontroller.text = widget.qty;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: myColor.whiteColor,
          ),
          title: Text(
            "Product Update",
            style: TextStyle(color: myColor.whiteColor),
          ),
          backgroundColor: myColor.themeColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.01,
              ),
              Text("Product Name"),
              SizedBox(
                height: mq.height * 0.009,
              ),
              Container(
                height: mq.height * 0.07,
                child: TextFormField(
                  controller: productnamecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: myColor.themeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: myColor.themeColor, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.009,
              ),
              Text("Product quantity"),
              SizedBox(
                height: mq.height * 0.009,
              ),
              Container(
                height: mq.height * 0.07,
                child: TextFormField(
                  controller: productquantitycontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: myColor.themeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: myColor.themeColor, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () {},
                buttonText: "Update",
                sizeWidth: double.infinity,
                buttonTextSize: mq.height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
