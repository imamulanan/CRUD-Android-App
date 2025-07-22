import 'package:crud_project/Screen/ProductCreateScreen.dart';
import 'package:crud_project/Screen/ProductUpdateScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../RestAPI/RestClient.dart';
import '../Style/Style.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool Loading = true;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    Loading = true;
    var data = await ProductGridViewListRequest();
    setState(() {
      ProductList = data;
      Loading = false;
    });
  }

  DeleteItem(id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ! "),
          content: Text("Once delete, you can't get it back"),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  Loading=true;
                });
                await ProductDeleteRequest(id);
                await CallData();
              },
              child: Text('Yes'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }


  GoToUpdate(context,ProductItem){
    Navigator.push(context,
        MaterialPageRoute(builder: (builder)=>ProductUpdateScreen(ProductItem)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Product")),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading
                ? (Center(child: CircularProgressIndicator()))
                : RefreshIndicator(
                    child: (GridView.builder(
                      gridDelegate: ProductGridViewStyle(),
                      itemCount: ProductList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  ProductList[index]['Img'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(ProductList[index]['ProductName']),
                                    SizedBox(height: 7),
                                    Text(
                                      "Price: " +
                                          ProductList[index]['UnitPrice'] +
                                          "BDT",
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            GoToUpdate(context,ProductList[index]);
                                          },
                                          child: Icon(
                                            CupertinoIcons
                                                .ellipsis_vertical_circle,
                                            size: 18,
                                            color: colorGreen,
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            DeleteItem(
                                              ProductList[index]['_id'],
                                            );
                                          },
                                          child: Icon(
                                            CupertinoIcons.delete,
                                            size: 18,
                                            color: colorRed,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                    onRefresh: () async {
                      await CallData();
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (builder)=>Productcreatescreen()));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
