import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required String userID, required String userName}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  bool isFavorite = false;
  int quantity = 0;
  double productRating = 3.5;
  bool isForSale = true; // Adjust the value based on your logic

  // @override
  // void initState() {
  //   super.initState();
  //   _fApp = Firebase.initializeApp();
  // }
  String ProductName = '';
  String ProductDescription = '';
  String ProductPhoto = '';
  String Status = '';
  String StartBidAmount = '0';
  String Category_Id = '0';
  String y = '';
  // String Seller_Id = '0';
  // String shipmentt_Id = '0';

  List<QueryDocumentSnapshot> docs = [];
  List<QueryDocumentSnapshot> sellers = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("product").get();
    docs.addAll(querySnapshot.docs);
    QuerySnapshot querySnapshot2 =
        await FirebaseFirestore.instance.collection("seller").get();
    sellers.addAll(querySnapshot2.docs);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 212, 255),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
        title: Text("${docs[0]["ProductName"]}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 375,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      '${docs[0]["ProductPhoto"]}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${docs[0]["ProductName"]}",
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "Description: ${docs[0]["ProductDescription"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "Start Bid Amount: ${docs[0]["StartBidAmount"]} EGP",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  for (var i = 0; i < sellers.length; i++)
                    if (sellers[i]['SellerID'] == docs[0]['Seller_Id']) ...[
                      Text(
                        "Company: ${sellers[i]['CompanyName']}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  for (var i = 0; i < sellers.length; i++)
                    if (sellers[i]['SellerID'] == docs[0]['Seller_Id']) ...[
                      Text(
                        "Seller: ${sellers[i]['Name']}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 248),
        color: const Color.fromARGB(255, 249, 212, 255),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {},
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          //Icon(Icons.picture_in_picture),
          Icon(Icons.shopping_cart),
          Icon(Icons.person),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isForSale
              ? FloatingActionButton.extended(
                  onPressed: () {
                    print('Add to cart tapped!');
                  },
                  icon:
                      const Icon(Icons.add_shopping_cart, color: Colors.black),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 232, 130, 248),
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    print('Book a Ticket tapped!');
                  },
                  icon: const Icon(Icons.confirmation_num, color: Colors.black),
                  label: const Text(
                    'Book a Ticket',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 232, 130, 248),
                ),
          const SizedBox(width: 10),
          const FloatingActionButton.extended(
            onPressed: null,
            icon: Icon(Icons.chat, color: Colors.black),
            label: Text(
              'Bid LiveChat',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.grey,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
