// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:maaldo_app/Maaldo%20App/Screens/Order%20List/order_list.dart';
// import 'package:maaldo_app/const/mycolor.dart';
// import 'package:maaldo_app/provider/cart_provider.dart';
// import 'package:maaldo_app/search/product_search.dart';
// import 'package:provider/provider.dart';

// class Customappbar extends StatefulWidget {
//   const Customappbar({Key? key}) : super(key: key);

//   @override
//   _CustomappbarState createState() => _CustomappbarState();
// }

// class _CustomappbarState extends State<Customappbar> {
//   @override
//   Widget build(BuildContext context) {
//     var mq = MediaQuery.of(context).size;
//     return Container(
//       // color: Colors.red,
//       child: Row(
//         children: [
//           Flexible(
//             child: TextFormField(
//               onTap: () {
//                 showModalBottomSheet(
//                   backgroundColor: Colors.white,
//                   isScrollControlled: true,
//                   shape: const BeveledRectangleBorder(),
//                   useSafeArea: true,
//                   context: context,
//                   builder: (context) {
//                     return const FractionallySizedBox(
//                       // heightFactor: 1,
//                       child: ProductSearch(),
//                     );
//                   },
//                 );
//               },
//               readOnly: true,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   contentPadding: EdgeInsets.symmetric(vertical: 10),
//                   hintText: 'Item search Karain',
//                   prefixIcon: Icon(FeatherIcons.search)),
//             ),
//           ),
//           Consumer<CartProvider>(
//             builder: (context, cartProvider, child) {
//               final cartItemsCount = cartProvider.cartItems.length;
//               return Badge(
//                 offset: Offset(-3, 5),
//                 label: Text(cartItemsCount.toString()),
//                 backgroundColor: mycolor.themecolor,
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.shopping_bag_outlined,
//                     size: 28,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context, rootNavigator: true).push(
//                       MaterialPageRoute(
//                         builder: (context) => const OrderList(),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
