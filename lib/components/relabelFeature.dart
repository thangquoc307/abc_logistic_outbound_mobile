import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/cascadeStyle/image.dart';
import 'package:flutter_outbound/dialog/bluetoothPrinterManageDialog.dart';
import 'package:flutter_outbound/dialog/noItemDialog.dart';
import 'package:flutter_outbound/dialog/printBarcodeDialog.dart';
import 'package:flutter_outbound/dialog/selectRelabelScannedDialog.dart';
import 'package:flutter_outbound/model/relabelDetail.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_outbound/service/util.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';

class RelabelFeature extends StatefulWidget {
  const RelabelFeature({super.key});

  @override
  State<RelabelFeature> createState() => _RelabelFeatureState();
}

class _RelabelFeatureState extends State<RelabelFeature> {
  List<RelabelDetail>? _relabelList;
  final GlobalKey _displayKey = GlobalKey();
  int _page = 0;
  int _totalPage = 0;
  int itemOfPage = 0;

  String _searchWord = "";
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDateRange(BuildContext context) async {
    if (_startDate != null) {
      _startDate = null;
      _endDate = null;
    } else {
      List<DateTime?>? picker = (await showCalendarDatePicker2Dialog(context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
              calendarType: CalendarDatePicker2Type.range,
              okButtonTextStyle: TextStyleMobile.h1_14.copyWith(color: MobileColor.orangeColor),
              cancelButtonTextStyle: TextStyleMobile.h1_14.copyWith(color: Colors.grey),
              selectedRangeDayTextStyle: TextStyleMobile.body_14.copyWith(color: MobileColor.orangeColor),
              selectedRangeHighlightColor: MobileColor.softOrangeColor,
              selectedDayHighlightColor: MobileColor.orangeColor
          ),
          dialogSize: Size(MediaQuery.of(context).size.width, 350)
      ));
      if(picker != null && picker.length == 2) {
        _startDate = picker[0];
        _endDate = picker[1]!.add(const Duration(days: 1));
      }
    }
    _page = 0;
    getRelabelDetail();
  }


  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      List<RelabelDetail>? relabelDetailScanned = await ApiConnector.getRelabelByOriginBarcode(barcodeScanRes);
      if(relabelDetailScanned == null || relabelDetailScanned.isEmpty) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const NoItemDialog();
            }
        );
      } else if (relabelDetailScanned.length == 1){
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return PrintBarcodeDialog(relabel: relabelDetailScanned[0],);
            }
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return SelectRelabelScannedDialog(list: relabelDetailScanned);
            }
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_displayKey.currentContext != null) {
        getRelabelDetail();
      }
    });
  }

  Future<void> getRelabelDetail() async {
    double heightItem = 75;
    double displayHeight = _displayKey.currentContext?.size?.height ?? 0;

    itemOfPage = (displayHeight / heightItem).floor();

    Map<String, dynamic>? newData = await ApiConnector.pageSearchRelabel(
        _page, _searchWord, itemOfPage, _searchWord, _startDate, _endDate);

    setState(() {
      if (newData != null) {
        _relabelList = newData["data"];
        _totalPage = newData["totalPages"];
      } else {
        _relabelList = [];
        _totalPage = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
    if(_relabelList != null) {
      if (_relabelList!.isNotEmpty) {
        list = List.from(_relabelList!);
        for (var i = itemOfPage; i > _relabelList!.length; i--){
          list.add(null);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              scanBarcodeNormal();
            },
          backgroundColor: MobileColor.orangeColor,
          child: const Icon(Icons.barcode_reader, color: Colors.white,),
        ),
        backgroundColor: MobileColor.grayButtonColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          title: Text("RELABEL FEATURE",
              style: TextStyleMobile.h1_14.copyWith(
                  color: MobileColor.orangeColor)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 5,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
              height: 65,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (value != null){
                          _page = 0;
                          _searchWord = value;
                          getRelabelDetail();
                        }
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Barcode",
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
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDateRange(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 15,),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: (_startDate == null)
                                ? Colors.grey
                                : MobileColor.orangeColor
                        )
                      ),
                      child: Icon(Icons.calendar_month_outlined,
                          color: (_startDate == null)
                              ? Colors.grey
                              : MobileColor.orangeColor
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MobileColor.blueButtonColor
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const BluetoothPrinterManageDialog();
                    },
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Brother HL-L23600",
                              style: TextStyleMobile.button_14.copyWith(
                                color: Colors.white
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                          ),
                          RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Condition: ",
                                    style: TextStyleMobile.body_12.copyWith(
                                      color: Colors.white
                                    )
                                  ),
                                  TextSpan(
                                    text: "Ready",
                                    style: TextStyleMobile.h2_12.copyWith(
                                      color: Colors.white
                                    )
                                  ),
                                ]
                              ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.cached, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                key: _displayKey,
                child: list.isEmpty
                  ? const Center(child: Image(image: AssetsImage.notFound),)
                  : Column(
                  children: list.map((e) {
                    if (e == null) {
                      return const Expanded(child: SizedBox());
                    }
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: MobileColor.grayButtonColor,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Icon(Icons.document_scanner_outlined,
                                          color: Colors.grey,
                                          size: 28,
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Original Barcode: ",
                                                        style: TextStyleMobile.body_12.copyWith(
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: e.originalBarcode ?? "",
                                                        style: TextStyleMobile.h2_12.copyWith(
                                                            color: Colors.black
                                                        ),
                                                      )
                                                    ]
                                                  )
                                              ),
                                              RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "New Barcode: ",
                                                          style: TextStyleMobile.body_12.copyWith(
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: e.newBarcode ?? "",
                                                          style: TextStyleMobile.h2_12.copyWith(
                                                              color: Colors.black
                                                          ),
                                                        )
                                                      ]
                                                  ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Text(Utils.convertFullTime(e.createdDate),
                                                    style: TextStyleMobile.body_12.copyWith(
                                                      color: Colors.grey
                                                    ),
                                                  ),
                                                ),
                                              )

                                            ],
                                          )
                                      )

                                    ],
                                  ),
                                ),
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 50,
                                height: double.infinity,
                                child: const Icon(Icons.print_outlined,
                                  size: 28,
                                  color: Colors.grey,
                                ),
                              ),

                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PrintBarcodeDialog(relabel: e,);
                                    }
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Utils.renderPageButton([_page, _totalPage], (value) {
              _page = value;
              getRelabelDetail();
            })
          ],
        ),

      ),
    );
  }
}
