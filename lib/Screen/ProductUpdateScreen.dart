import 'package:crud_application/RestAPI/RestClient.dart';
import 'package:crud_application/Screen/ProductGridViewScreen.dart';
import 'package:crud_application/Style/Style.dart';
import 'package:flutter/material.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen(this.productItem);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": "",
  };
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      FormValues.update("Img", (value) => widget.productItem["Img"]);
      FormValues.update(
          "ProductCode", (value) => widget.productItem["ProductCode"]);
      FormValues.update(
          "ProductName", (value) => widget.productItem["ProductName"]);
      FormValues.update("Qty", (value) => widget.productItem["Qty"]);
      FormValues.update(
          "TotalPrice", (value) => widget.productItem["TotalPrice"]);
      FormValues.update(
          "UnitPrice", (value) => widget.productItem["UnitPrice"]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: isLoading
                ? createCircularProgressIndicator()
                : createProductFillupForm(),
          ),
        ],
      ),
    );
  }

  Center createCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white70,
        strokeWidth: 10,
      ),
    );
  }

  SingleChildScrollView createProductFillupForm() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: height * 0.25,
            width: width * 0.60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Image.network(FormValues["Img"]!, fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    "https://th.bing.com/th/id/OIP.iEE5Pq8P83xrKvMzG3g4GQE8DF?pid=ImgDet&rs=1",
                    fit: BoxFit.contain,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: FormValues["ProductName"],
            onChanged: (value) {
              InputOnChange("ProductName", value);
            },
            decoration: AppInputDecoration('Product Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: FormValues["Img"],
            onChanged: (value) {
              InputOnChange("Img", value);
            },
            decoration: AppInputDecoration('Product Image Url'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: FormValues["ProductCode"],
            onChanged: (value) {
              InputOnChange("ProductCode", value);
            },
            decoration: AppInputDecoration('Product Code'),
          ),
          const SizedBox(
            height: 20,
          ),
          // AppDropDownStyle(
          //   _dropDownMenuItem(),
          // ),
          TextFormField(
            initialValue: FormValues["Qty"],
            onChanged: (value) {
              InputOnChange("Qty", value);
            },
            decoration: AppInputDecoration('Quantity'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: FormValues["UnitPrice"],
            onChanged: (value) {
              InputOnChange("UnitPrice", value);
            },
            decoration: AppInputDecoration('Unit Price'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: FormValues["TotalPrice"],
            onChanged: (value) {
              InputOnChange("TotalPrice", value);
            },
            decoration: AppInputDecoration('Total Price'),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                FormOnSubmit();
              },
              child: SuccessButtonChild('Submit'),
              style: ApplyButtonStyle(),
            ),
          ),
        ],
      ),
    );
  }

  InputOnChange(key, value) {
    FormValues[key] = value;
    setState(() {});
  }

  FormOnSubmit() async {
    if (FormValues['ProductName'] == '') {
      ErrorToast('Product Name Required !');
    } else if (FormValues['Img'] == '') {
      ErrorToast('Image Link Required !');
    } else if (FormValues['ProductCode'] == '') {
      ErrorToast('Product Code Required !');
    } else if (FormValues['Qty'] == '') {
      ErrorToast('Product quantity Required !');
    } else if (FormValues['TotalPrice'] == '') {
      ErrorToast('Total Price Required !');
    } else if (FormValues['UnitPrice'] == '') {
      ErrorToast('Unit Price Required !');
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      await ProductUpdateRequest(FormValues, widget.productItem["_id"]);
      // setState(() {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (builder) => ProductGridViewScreen()),
      //       (Route route) => false);
      //   isLoading = !isLoading;
      // });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => ProductGridViewScreen()),
          (Route route) => false);
    }
  }

  DropdownButton<String> _dropDownMenuItem() {
    return DropdownButton(
      value: FormValues['Qty'],
      items: const [
        DropdownMenuItem(
          value: '',
          child: Text('Select Qt'),
        ),
        DropdownMenuItem(
          value: '1 pcs',
          child: Text('1 pcs'),
        ),
        DropdownMenuItem(
          value: '2 pcs',
          child: Text('2 pcs'),
        ),
        DropdownMenuItem(
          value: '3 pcs',
          child: Text('3 pcs'),
        ),
        DropdownMenuItem(
          value: '4 pcs',
          child: Text('4 pcs'),
        ),
        DropdownMenuItem(
          value: '5 pcs',
          child: Text('5pcs'),
        ),
      ],
      onChanged: (value) {
        InputOnChange("Qty", value);
      },
      isExpanded: true,
      underline: Container(),
    );
  }
}
