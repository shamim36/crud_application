import 'package:crud_application/RestAPI/RestClient.dart';
import 'package:crud_application/Screen/ProductCreateScreen.dart';
import 'package:crud_application/Screen/ProductUpdateScreen.dart';
import 'package:crud_application/Style/Style.dart';
import 'package:crud_application/Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool isLoading = false;

  @override
  void initState() {
    CallData();
    super.initState();
  }

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
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white70,
                    strokeWidth: 10,
                  ))
                : refreshIndicator(context),
          ),
        ],
      ),
      floatingActionButton: goToCreateScreen(context),
    );
  }



  RefreshIndicator refreshIndicator(context) {
    return RefreshIndicator(
      onRefresh: () async {
        await CallData();
      },
      child: GridView.builder(
        itemCount: ProductList.length,
        gridDelegate: ProductGridViewStyle(),
        itemBuilder: (context, index) {
          return CardView(index);
        },
      ),
    );
  }

  DeleteItem(id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete !'),
          content: Text('Once delete, you can\'t get it back.'),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  isLoading = true;
                });
                await ProductDeleteRequest(id);
                CallData();
              },
              child: Text('Yes'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                ErrorToast(" Item Deleted Unsuccessful!");
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Card CardView(index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(ProductList[index]["Img"], fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  "https://th.bing.com/th/id/OIP.iEE5Pq8P83xrKvMzG3g4GQE8DF?pid=ImgDet&rs=1",
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          Expanded(
            flex: 40,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 30,
                    child:
                        ProductName(context,index, ProductList[index]["ProductName"]),
                  ),
                  Expanded(
                    flex: 30,
                    child: ProductUnitPrice(
                        context,index, ProductList[index]["UnitPrice"]),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    flex: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        goToUpdateScreen(context,ProductList[index]),
                        SizedBox(width: 4),
                        OutlinedButton(
                          onPressed: () {
                            DeleteItem(ProductList[index]["_id"]);
                          },
                          child: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Future<void> CallData() async {
    setState(() {
      isLoading = true;
    });
    var data = await ProductGridViewList();
    setState(() {
      ProductList = data;
      isLoading = false;
    });
  }
}
