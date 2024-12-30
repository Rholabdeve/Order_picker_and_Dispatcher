import 'package:delivery_man/services/global.dart';
import 'package:delivery_man/widgets/custom_container.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchDesign extends StatefulWidget {
  int discount = 0;
  final String title;
  final String image;
  final String price;
  final String? product_mrps;
  VoidCallback? onTap;
  SearchDesign({
    Key? key,
    required this.onTap,
    required this.discount,
    required this.title,
    required this.image,
    required this.price,
    this.product_mrps,
  }) : super(key: key);

  @override
  _SearchDesignState createState() => _SearchDesignState();
}

class _SearchDesignState extends State<SearchDesign> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Stack(
      // alignment: Alignment.bottomRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ListTile(
                onTap: widget.onTap,
                leading: Container(
                  height: mq.height * 0.15,
                  width: mq.width * 0.15,
                  decoration: BoxDecoration(
                      // // Additional decoration properties if needed
                      // border: Border.all(color: Colors.black, width: 2.0),
                      // borderRadius: BorderRadius.circular(8.0),
                      ),
                  child: Image.network(
                    globalKeys.imageUrl + widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  '${widget.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Discount Price

                    // Actual Price
                    Text(
                      'Rs. ${widget.price}',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    // widget.discount == 0
                    //     ? Container()
                    //     : Text(
                    //         "Rs. ${widget.product_mrps}",
                    //         style: TextStyle(
                    //           fontSize: 13,
                    //           color: Colors.red,
                    //           fontWeight: FontWeight.bold,
                    //           decoration: TextDecoration.lineThrough,
                    //         ),
                    //       ),
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
        widget.discount == 0
            ? Container()
            : Positioned(
                // top: mq.height * 0.01,
                // left: mq.width * 0.1,
                right: mq.width * 0.05,
                bottom: mq.height * 0.09,
                child: Column(
                  children: [
                    CustomContainer(
                      sizeHeight: mq.height * 0.03,
                      sizeWidth: mq.width * 0.15,
                      color: Colors.green,
                      radius: 10,
                      child: Center(
                        child: Text(
                          "${widget.discount}% Off",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        widget.discount == 0
            ? Container()
            : Positioned(
                right: mq.width * 0.071,
                top: mq.height * 0.06,
                child: Text(
                  'Rs. ${widget.product_mrps}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                )),
      ],
    );
  }
}
