import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/cascadeStyle/input.dart';
import 'package:flutter_outbound/dialog/addRequestedDialog.dart';
import 'package:flutter_outbound/dialog/locationDialog.dart';
import 'package:flutter_outbound/dialog/requestedQTYDialog.dart';
import 'package:flutter_outbound/model/billing.dart';
import 'package:flutter_outbound/model/customer.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:flutter_outbound/model/shippingAddress.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class Step01 extends StatefulWidget {
  const Step01({super.key});

  @override
  State<Step01> createState() => _Step01State();
}

class _Step01State extends State<Step01> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static bool _formMode = true;

  static const List<String> _channelList = ["ECOMMERCE", "WOOCOMMERCE"];
  static const List<String> _storeList = ["AMAZON", "ALIEXPRESS"];
  static const List<String> _statusList = ["OPEN", "ACKNOWLEDGED"];
  static const List<String> _shipTypeList = ["masterCarton", "unit"];

  static List<Customer>? _customerList;

  Future<void> getCustomerList() async {
    List<Customer>? data = await ApiConnector.getAllCustomer();
    if (data != null){
      _customerList = data;
    }
  }
  @override
  void initState() {
    super.initState();
    getCustomerList();
    _formMode = true;
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context, listen: true);
    TextEditingController _outboundOrderNoController = TextEditingController(
        text: state.objectForm.orderNo
    );
    TextEditingController _customerController = TextEditingController(
        text: state.objectForm.customer?.customerName ?? ""
    );
    TextEditingController _issuerController = TextEditingController(
        text: state.objectForm.issuser
    );
    TextEditingController _senderController = TextEditingController(
        text: state.objectForm.sender
    );
    TextEditingController _receiverController = TextEditingController(
        text: state.objectForm.receiver
    );
    TextEditingController _noteController = TextEditingController(
        text: state.objectForm.note
    );

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(child: InkWell(
                  onTap: () {
                    setState(() {
                      _formMode = true;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _formMode ? Colors.white : null,
                      borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(12))
                    ),
                    child: Text("Form", style: TextStyleMobile.body_14.copyWith(
                      color: _formMode ? MobileColor.orangeColor : Colors.grey
                    )),
                  ),
                )),
                Expanded(child: InkWell(
                  onTap: () {
                    setState(() {
                      if (state.objectForm.customer?.customerId != null) {
                        state.getProductByCustomerId(state.objectForm.customer!.customerId);
                        _formMode = false;
                      } else {
                        Utils.showSnackBarAlert(context, "Please choose Customer");
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: !_formMode ? Colors.white : null,
                        borderRadius: const BorderRadiusDirectional.only(topStart: Radius.circular(12))
                    ),
                    child: Text("Product", style: TextStyleMobile.body_14.copyWith(
                        color: !_formMode ? MobileColor.orangeColor : Colors.grey
                    )),
                  ),
                )),
              ],
            ),
          ),
            Expanded(
              child: Container(
                color: Colors.white,
                  child: _formMode
                    ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            color: Colors.white,
                            child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Outbound Order No.",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                    controller: _outboundOrderNoController,
                                    validator: (value) => Utils.validateRequire(value, "Outbound Order No."),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm,
                                  onChanged: (value) {
                                    state.objectForm.orderNo = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Issuer",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                  readOnly: true,
                                    controller: _issuerController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Customer Name",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TypeAheadField<Customer>(
                                  constraints: const BoxConstraints(maxHeight: 300),
                                  controller: _customerController,
                                  builder: (context, controller, focusNode) {
                                    return TextFormField(
                                      decoration: InputStyle.inputTextForm,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      controller: controller,
                                      validator: (value) => Utils.validateRequire(value, "Customer"),
                                    );
                                  },
                                  suggestionsCallback: (search) async {
                                    return Future.value(
                                      _customerList
                                          ?.where((element) =>
                                      element.customerName?.toLowerCase()
                                          .contains(search
                                          .toLowerCase()) ?? false)
                                          .toList(),
                                    );
                                  },
                                  itemBuilder: (context, customer) {
                                    return ListTile(
                                      title: Text(
                                          customer.customerName ?? "",
                                          style: TextStyleMobile.button_14
                                      ),
                                    );
                                  },
                                  onSelected: (Customer value) {
                                    setState(() {
                                      state.objectForm.customer = value;
                                    });
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Billing",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                  validator: (value) => Utils.validateLocation(value, "Billing"),
                                  controller: TextEditingController(
                                    text:
                                        "${state.objectForm.billing?.addressOne ?? ''}, "
                                        "${state.objectForm.billing?.addressTwo ?? ''}, "
                                        "${state.objectForm.billing?.city ?? ''}, "
                                        "${state.objectForm.billing?.state ?? ''}, "
                                        "${state.objectForm.billing?.zipCode ?? ''}, "
                                        "${state.objectForm.billing?.country ?? ''}"
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BillingDialog(dataSubmit: (Map<String, String> map) {
                                            setState(() {
                                              state.objectForm.billing = Billing(null, null,
                                                  map['add1'], map['add2'],
                                                  map['city'], map['state'],
                                                  map['zipcode'], map['country']);
                                            });
                                          }, initValue: state.objectForm.billing,);
                                        },
                                    );
                                  },
                                  readOnly: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Channel",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                DropdownButtonFormField<String>(
                                  value: state.objectForm.channel?.toUpperCase(),
                                  hint: const Text("Select channel"),
                                  decoration: InputStyle.inputTextForm,
                                  items: _channelList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e.toUpperCase(),
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  validator: (value) => Utils.validateRequire(value, "Channel"),
                                  onChanged: (String? value) {
                                    state.objectForm.channel = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Store",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                DropdownButtonFormField<String>(
                                  value: state.objectForm.store?.toUpperCase(),
                                  hint: const Text("Select store"),
                                  decoration: InputStyle.inputTextForm,
                                  items: _storeList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e.toUpperCase(),
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  validator: (value) => Utils.validateRequire(value, "Store"),
                                  onChanged: (String? value) {
                                    state.objectForm.store = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Create Date",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextField(
                                    controller: TextEditingController(
                                      text: Utils.convertTime(state.objectForm.createdDate)
                                    ),
                                      textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.lockTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Last updated by",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextField(
                                    controller: TextEditingController(
                                        text: Utils.convertTime(state.objectForm.lastModifiedDate)
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.lockTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Status",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                DropdownButtonFormField<String>(
                                  value: state.objectForm.status?.toUpperCase(),
                                  hint: const Text("Select status"),
                                  decoration: InputStyle.inputTextForm,
                                  items: _statusList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e.toUpperCase(),
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  validator: (value) => Utils.validateLocation(value, "Status"),
                                  onChanged: (String? value) {
                                    state.objectForm.status = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Sender",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                  controller: _senderController,
                                    validator: (value) => Utils.validateRequire(value, "Sender"),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm,
                                  onChanged: (value) {
                                    state.objectForm.sender = value;
                                  },

                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Receiver",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                  controller: _receiverController,
                                    validator: (value) => Utils.validateRequire(value, "Receiver"),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm,
                                  onChanged: (value) {
                                    state.objectForm.receiver = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Ship From",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                    validator: (value) => Utils.validateLocation(value, "Ship from"),
                                    controller: TextEditingController(
                                        text:
                                        "${state.objectForm.shipFromAddress?.addressOne ?? ''}, "
                                            "${state.objectForm.shipFromAddress?.addressTwo ?? ''}, "
                                            "${state.objectForm.shipFromAddress?.city ?? ''}, "
                                            "${state.objectForm.shipFromAddress?.state ?? ''}, "
                                            "${state.objectForm.shipFromAddress?.zipCode ?? ''}, "
                                            "${state.objectForm.shipFromAddress?.country ?? ''}"
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BillingDialog(dataSubmit: (Map<String, String> map) {
                                            setState(() {
                                              state.objectForm.shipFromAddress = ShippingAddress(null,
                                                  map['add1'], map['add2'],
                                                  map['city'], map['state'],
                                                  map['zipcode'], map['country']);
                                            });
                                          }, initValue: state.objectForm.shipFromAddress,);
                                        },
                                      );
                                    },
                                    readOnly: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Ship To",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                    validator: (value) => Utils.validateLocation(value, "Ship to"),
                                    controller: TextEditingController(
                                        text:
                                        "${state.objectForm.shipToAddress?.addressOne ?? ''}, "
                                            "${state.objectForm.shipToAddress?.addressTwo ?? ''}, "
                                            "${state.objectForm.shipToAddress?.city ?? ''}, "
                                            "${state.objectForm.shipToAddress?.state ?? ''}, "
                                            "${state.objectForm.shipToAddress?.zipCode ?? ''}, "
                                            "${state.objectForm.shipToAddress?.country ?? ''}"
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BillingDialog(dataSubmit: (Map<String, String> map) {
                                            setState(() {
                                              state.objectForm.shipToAddress = ShippingAddress(null,
                                                  map['add1'], map['add2'],
                                                  map['city'], map['state'],
                                                  map['zipcode'], map['country']);
                                            });
                                          }, initValue: state.objectForm.shipToAddress,);
                                        },
                                      );
                                    },
                                    readOnly: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "ETD",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                InkWell(
                                  onTap: () async {
                                    DateTime? result = await Utils.selectDate(context, state.objectForm.etd);
                                    if (result != null) {
                                      setState(() {
                                        state.objectForm.etd = result;
                                      });
                                    }
                                  },
                                  child: TextFormField(
                                    controller: TextEditingController(
                                      text: Utils.convertTime(state.objectForm.etd)
                                    ),
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputStyle.dateForm,
                                  ),
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "ETA",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                InkWell(
                                  onTap: () async {
                                    DateTime? result = await Utils.selectDate(context, state.objectForm.eta);
                                    if (result != null) {
                                      setState(() {
                                        state.objectForm.eta = result;
                                      });
                                    }
                                  },
                                  child: TextFormField(
                                      controller: TextEditingController(
                                          text: Utils.convertTime(state.objectForm.eta)
                                      ),
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputStyle.dateForm,
                                  ),
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Note",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                TextFormField(
                                    controller: _noteController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputStyle.inputTextForm,
                                  onChanged: (value) {
                                    state.objectForm.note = value;
                                  },
                                ),
                                InputStyle.offsetForm,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Ship Type",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.black)
                                        ),
                                        TextSpan(text: " *",
                                            style: TextStyleMobile.h1_14.
                                            copyWith(color: Colors.red)
                                        ),
                                      ]
                                  )),
                                ),
                                InputStyle.offsetText,
                                DropdownButtonFormField<String>(
                                  value: state.objectForm.shipType?.toUpperCase(),
                                  hint: const Text("Select ship type"),
                                  decoration: InputStyle.inputTextForm,
                                  items: _shipTypeList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e.toUpperCase(),
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  validator: (value) => Utils.validateRequire(value, "Ship Type"),
                                  onChanged: (String? value) {
                                    state.objectForm.shipType = value;
                                  },
                                ),
                              ],
                            )
                          ),
                        ),
                      ) :
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                            height: 65,
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                    TextField(
                                      onChanged: (value) {

                                      },
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          hintText: "Search UPC",
                                          hintStyle: TextStyle(
                                              color: Colors.grey
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  style: BorderStyle.solid,
                                                  color: Colors.grey
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: MobileColor.orangeColor,
                                                  width: 2
                                              )
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 0)
                                      ),
                                    )
                              ),
                              const SizedBox(width: 10,),
                              IconButton(
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AddRequestedDialog();
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      )),
                                      side: const MaterialStatePropertyAll(BorderSide(
                                          color: Colors.grey,
                                          style: BorderStyle.solid,
                                          width: 1
                                      ))
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: state.objectForm.outboundProductDetails!.map((e) {
                                return Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: MobileColor.grayButtonColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        alignment: Alignment.topRight,
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Image.asset('assets/images/Vector.png'),
                                        ),
                                      ),
                                      Expanded(child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(e.product?.name ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyleMobile.h2_12,),
                                            Text("SKU: ${e.sku}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyleMobile.body_12,),
                                            RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(text: "Requested QTY: ",
                                                      style: TextStyleMobile.body_12.copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                    TextSpan(text: e.requestedQty.toString(),
                                                      style: TextStyleMobile.h2_12.copyWith(
                                                          color: MobileColor.greenButtonColor
                                                      ),
                                                    ),
                                                  ]
                                                )
                                            ),
                                          ],
                                        ),
                                      )),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return RequestedQTYDialog(editedElement: e,);
                                            },
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          width: 30,
                                          padding: const EdgeInsets.only(right: 10, top: 10),
                                          child: const Icon(Icons.edit_square, color: Colors.grey, size: 20),
                                        ),
                                      )
                                    ],
                                  ),

                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 30),
                height: 90,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10
                    )
                  ],
                  borderRadius: const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(24),
                      topStart: Radius.circular(24)
                  ),
                  color: Colors.white
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: MobileColor.orangeColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: TextButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          if(state.objectForm.outboundProductDetails == null || state.objectForm.outboundProductDetails!.isEmpty){
                            Utils.showSnackBarAlert(context, "Please choose Products");
                          } else {
                            ApiConnector.createOutbound(
                                state.objectForm,
                                state.create
                            );
                            Utils.showSnackBar(context, "Data is saved");
                            if (state.finishStep == 0){
                              state.finishStep++;
                            }
                            state.currentStep = 1;
                          }
                        }
                      },
                      child: Text("Next", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}
