import 'package:crud_project/Style/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../RestAPI/RestClient.dart';

class Productcreatescreen extends StatefulWidget {
  @override
  State<Productcreatescreen> createState() => _ProductcreatescreenState();
}

class _ProductcreatescreenState extends State<Productcreatescreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": "",
  };

  bool Loading = false;

  InputOnChange(Mapkey, Textvalue) {
    setState(() {
      FormValues.update(Mapkey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['Img']!.length == 0) {
      ErrorToast('Image Link Required');
    } else if (FormValues['ProductCode']!.length == 0) {
      ErrorToast('Product Code Required');
    } else if (FormValues['ProductName']!.length == 0) {
      ErrorToast('Product Name Required');
    } else if (FormValues['Qty']!.length == 0) {
      ErrorToast('Qty Required');
    } else if (FormValues['TotalPrice']!.length == 0) {
      ErrorToast('Total Price Required');
    } else if (FormValues['UnitPrice']!.length == 0) {
      ErrorToast('Unit Price Required');
    } else {
      setState(() {
        Loading = true;
      });
      await ProductCreateRequest(FormValues);
      setState(() {
        Loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Product")),
      body: Stack(
        children: [
          // Background picture
          ScreenBackground(context),
          Container(
            child: Loading
                ? (Center(child: CircularProgressIndicator()))
                : ((SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("ProductName", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Name'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("ProductCode", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Code'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("Img", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Image'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("UnitPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Unit Price'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("TotalPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Total Price'),
                        ),
                        SizedBox(height: 20),

                        AppDropDownStyle(
                          DropdownButton<String>(
                            value: (FormValues['Qty'] != null &&
                                ['1 pcs', '2 pcs', '3 pcs', '4 pcs', ''].contains(FormValues['Qty']))
                                ? FormValues['Qty']
                                : '', // Set default if invalid or null

                            items: [
                              DropdownMenuItem(
                                child: Text('Select Qt'),
                                value: "",
                              ),
                              DropdownMenuItem(
                                child: Text('1 pcs'),
                                value: "1 pcs",
                              ),
                              DropdownMenuItem(
                                child: Text('2 pcs'),
                                value: "2 pcs",
                              ),
                              DropdownMenuItem(
                                child: Text('3 pcs'),
                                value: "3 pcs",
                              ),
                              DropdownMenuItem(
                                child: Text('4 pcs'),
                                value: "4 pcs",
                              ),
                            ],

                            onChanged: (Textvalue) {
                              InputOnChange("Qty", Textvalue);
                            },

                            underline: Container(),
                            isExpanded: true,
                          ),
                        ),


                        SizedBox(height: 20),

                        Container(
                          child: ElevatedButton(
                            style: AppButtonStyle(),
                            onPressed: () {
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ))),
          ),
        ],
      ),
    );
  }
}
