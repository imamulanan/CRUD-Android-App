import 'dart:convert';
import 'package:crud_project/Style/Style.dart';
import 'package:http/http.dart' as http;

Future<List> ProductGridViewListRequest() async {
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader={"Content-Type":"application/json"};
  var response= await http.get(URL,headers: PostHeader);

  var ResultCode=response.statusCode;
  var ResultBody=jsonDecode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request Failed");
    return [];
  }
}

Future<bool> ProductCreateRequest(FormValues) async {
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody=jsonEncode(FormValues);
  var PostHeader={"Content-Type":"application/json"};
  var response= await http.post(URL,headers: PostHeader,body: PostBody);
  var ResultCode=response.statusCode;
  var ResultBody=jsonDecode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request Failed");
    return false;
  }
}


Future<bool> ProductDeleteRequest(id) async{
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  var PostHeader={"Content-Type":"application/json"};
  var response = await http.get(URL,headers: PostHeader);

  var ResultCode=response.statusCode;
  var ResultBody=jsonDecode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request Failed");
    return false;
  }
}

Future<bool> ProductUpdateRequest(FormValues,id) async {
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/"+id);
  var PostBody=jsonEncode(FormValues);
  var PostHeader={"Content-Type":"application/json"};
  var response= await http.post(URL,headers: PostHeader,body: PostBody);
  var ResultCode=response.statusCode;
  var ResultBody=jsonDecode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request Failed");
    return false;
  }
}