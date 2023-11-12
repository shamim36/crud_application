import 'dart:convert';
import 'package:crud_application/Style/Style.dart';
import 'package:http/http.dart' as http;

Future<bool> ProductCreateRequest(FormValues) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody = json.encode(FormValues);
  var PostHeader = {"Content-Type": "application/json"};

  try {
    var response = await http.post(URL, headers: PostHeader, body: PostBody);
    var ResultCode = response.statusCode;
    var ResultBody = jsonDecode(response.body);

    if (ResultCode == 200 && ResultBody["status"] == "success") {
      SuccessToast("Request Success!");
      return true;
    } else {
      ErrorToast("Request Failed: ${ResultBody['message']}");
      return false;
    }
  } catch (e) {
    print("ProductCreateRequest Error: $e");
    ErrorToast("Request Failed! Try again.");
    return false;
  }
}

Future<List> ProductGridViewList() async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {"Content-Type": "application/json"};

  try {
    var response = await http.get(URL, headers: PostHeader);
    var ResultCode = response.statusCode;
    var ResultBody = jsonDecode(response.body);

    if (ResultCode == 200 && ResultBody["status"] == "success") {
      SuccessToast("Request Success!");
      return ResultBody["data"];
    } else {
      ErrorToast("Request Failed: ${ResultBody['message']}");
      return [];
    }
  } catch (e) {
    print("ProductGridViewList Error: $e");
    ErrorToast("Request Failed! Try again.");
    return [];
  }
}

Future<bool> ProductDeleteRequest(id) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
    var PostHeader = {"Content-Type": "application/json"};

    try {
    var response = await http.get(URL, headers: PostHeader);
    var ResultCode = response.statusCode;
    var ResultBody = jsonDecode(response.body);

    if (ResultCode == 200 && ResultBody["status"] == "success") {
      SuccessToast("Delete Request Success!");
      return true;
    } else {
      ErrorToast("Delete Request Failed: ${ResultBody['message']}");
      return false;
    }
  } catch (e) {
    print("ProductDeleteRequest Error: $e");
    ErrorToast("Delete Request Failed! Try again.");
    return false;
  }
}