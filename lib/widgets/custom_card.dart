// ignore_for_file: must_be_immutable

import 'package:delivery_man/services/global.dart';
import 'package:delivery_man/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCard extends StatefulWidget {
  int discount = 0;
  final String image;
  final String name;
  final String price;
  final String? product_mrps;
  VoidCallback? onTap;
  Widget? child;
  CustomCard(
      {Key? key,
      required this.image,
      required this.name,
      this.product_mrps,
      this.child,
      required this.price,
      required this.discount,
      this.onTap})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomContainer(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * 0.03, vertical: mq.height * 0.02),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: globalKeys.imageUrl + widget.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey, // You can customize the color
                      ),
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.white, // You can customize the color
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // flex: 2,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Rs ${widget.price}',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.00,
                ),
                widget.discount == 0
                    ? Container()
                    : Text(
                        "Rs ${widget.product_mrps}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${widget.name.toUpperCase()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: mq.height * 0.01),
                Container(
                  child: widget.child,
                ),
              ],
            ),
            widget.discount == 0
                ? Container()
                : CustomContainer(
                    sizeHeight: mq.height * 0.044,
                    sizeWidth: mq.width * 0.2,
                    color: Colors.green,
                    radius: 24,
                    child: Center(
                      child: Text(
                        "${widget.discount}% Off",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
