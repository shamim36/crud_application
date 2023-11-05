
import 'package:crud_application/RestAPI/RestClient.dart';
import 'package:crud_application/Style/Style.dart';
import 'package:flutter/material.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            
          ),
        ],
      ),
    );
  }

  CallData() async{
    isLoading = true;
    var data = await ProductGridViewList();
  }
}