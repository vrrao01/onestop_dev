import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../globals/my_colors.dart';
import '../../../globals/my_fonts.dart';
import 'package:onestop_dev/pages/quick_link/ip/ip_settings.dart';
import 'ip_helpers.dart';

bool fg = true;

class RouterPage extends StatefulWidget {
  static String id = "/ip";
  const RouterPage({Key? key}) : super(key: key);
  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int page = 1;
  CarouselController _buttonCarouselController = CarouselController();
  TextEditingController roomController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  hostelDetails hostel =
      hostelDetails("nothing", "--", "--=-=-===", "something");
  String dropdownValue = "Select Hostel";
  final _keyform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {page = 1;});
  }

  @override
  Widget build(BuildContext context) {
    double HEIGHT = MediaQuery.of(context).size.height;
    double WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: HEIGHT * 0.064,
        backgroundColor: kAppBarGrey,
        leading: Container(),
        leadingWidth: 0,
        title: Text(
          'Internet Settings',
          style: MyFonts.medium.setColor(kWhite),
        ),
        actions: [
          IconButton(
              onPressed: () {Navigator.of(context).pop();},
              icon: Icon(IconData(0xe16a, fontFamily: 'MaterialIcons')))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: HEIGHT * (1-0.064),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Text(
                  'You might need to change some of your laptop settings before you could start using the internet in your room. Go through the following steps after connecting your laptop to the LAN port. ',
                  style: MyFonts.medium.size(14).setColor(kGrey8),
                ),
              ),
              Container(
                height: HEIGHT * 0.69,
                width: WIDTH * 0.93,
                decoration: BoxDecoration(
                    color: kAppBarGrey,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, HEIGHT * 0.03073, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CarouselSlider(
                        items: [1, 2, 3, 4, 5, 6, 7, 8].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: HEIGHT * 0.0256,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Step $i of 8',
                                          style: MyFonts.medium.size(16).setColor(kWhite),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: HEIGHT * 0.0064,),
                                  Text(
                                    textdata[i - 1],
                                    style: MyFonts.regular.size(14).setColor(kGrey6),
                                  ),
                                  SizedBox(height: HEIGHT * 0.0064,),
                                  (i == 6)
                                      ? Form(
                                          key: _keyform,
                                          child: Column(
                                            children: [
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              Theme(
                                                data: Theme.of(context).copyWith(canvasColor: kBlueGrey),
                                                child: SizedBox(
                                                  height: HEIGHT * 0.0768156,
                                                  child: DropdownButtonFormField<String>(
                                                    value: dropdownValue,
                                                    icon: Icon(Icons.arrow_drop_down),
                                                    style: MyFonts.medium.size(16).setColor(kWhite),
                                                    onChanged: (data) {
                                                      setState(() {
                                                        dropdownValue = data!;
                                                        hostel.hostelName = dropdownValue;
                                                      });
                                                      print(hostel);
                                                    },
                                                    decoration: decfunction(''),
                                                    items: spinnerItems.map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value, style: MyFonts.medium.size(15).setColor(kWhite),),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              IpField(texta: "Remember your room number correctly", textb: 'Room Number', hostel: hostel, control: roomController, ht: HEIGHT,),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              IpField(texta: "remember your block number correctly", textb: 'Block', hostel: hostel, control: blockController, ht: HEIGHT,),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              IpField(texta: "remember your floor number correctly", textb: 'Floor', hostel: hostel, control: floorController, ht: HEIGHT,),
                                            ],
                                          ),
                                        ) : (i == 7) ? IpPage(argso: hostel) :
                                  (i == 5)? Image.asset('assets/images/lan5.png', height: HEIGHT*0.37646,):
                                  (i == 4)? Image.asset('assets/images/lan4.png', height: HEIGHT*0.40646,):
                                  (i != 8) ? SizedBox(height: HEIGHT*0.35646, child: Image.asset('assets/images/lan'+i.toString()+'.png')) : SizedBox(height: HEIGHT*0,)
                                ],
                              );
                            },
                          );
                        }).toList(),
                        carouselController: _buttonCarouselController,
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.95,
                            aspectRatio: 0.74,
                            initialPage: 0,
                            scrollPhysics: NeverScrollableScrollPhysics()),
                      ),
                      SizedBox(
                        height: HEIGHT * 0.03,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (page != 1) {
                                  await _buttonCarouselController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                  setState(() {page = page - 1;});
                                }
                              },
                              icon: Icon(Icons.chevron_left, color: page != 1 ? kWhite2 : kGrey7,),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (page < 8 && page != 6) {
                                  await _buttonCarouselController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                  setState(() {page = page + 1;});
                                } else if (page == 6) {
                                  if (dropdownValue != 'Select Hostel') {
                                    if (_keyform.currentState!.validate()) {
                                      fg = false;
                                      await _buttonCarouselController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                      setState(() {
                                        page = page + 1;
                                      });
                                    }
                                  }
                                }
                              },
                              icon: Icon(Icons.chevron_right, color: page != 8 ? kWhite2 : kGrey7,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: HEIGHT*0.001,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Form(
                                          key: _keyform,
                                          child: Column(
                                            children: [
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              Theme(
                                                data: Theme.of(context).copyWith(
                                                    canvasColor: kBlueGrey),
                                                child: SizedBox(
                                                  height: HEIGHT * 0.0768156,
                                                  child: DropdownButtonFormField<
                                                      String>(
                                                    value: dropdownValue,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    style: MyFonts.medium.size(16).setColor(kWhite),
                                                    onChanged: (data) {
                                                      setState(() {
                                                        dropdownValue = data!;
                                                        hostel.hostelName =
                                                            dropdownValue;
                                                      });
                                                      print(hostel);
                                                    },
                                                    decoration: decfunction(''),
                                                    items: spinnerItems.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value,
                                                            style: MyFonts.medium.size(15).setColor(kWhite),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              SizedBox(
                                                height: HEIGHT * 0.0768156,
                                                child: TextFormField(
                                                    style: TextStyle(color: kWhite),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Remember your room number correctly";
                                                      }
                                                      return null;
                                                    },
                                                    controller: roomController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    onChanged: (v) {
                                                      roomController.text = v;
                                                      hostel.roomNo = v;
                                                      roomController.selection = TextSelection.fromPosition(
                                                          TextPosition(offset: roomController.text.length)
                                                      );
                                                    },
                                                    decoration: decfunction('Room Number')),
                                              ),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              SizedBox(
                                                height: HEIGHT * 0.0768156,
                                                child: TextFormField(
                                                    style: TextStyle(color: kWhite),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "remember your block number correctly";
                                                      }
                                                      return null;
                                                    },
                                                    controller: blockController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (v) {
                                                      blockController.text = v;
                                                      hostel.block = v;
                                                      blockController.selection =
                                                          TextSelection.fromPosition(
                                                              TextPosition(
                                                                  offset:
                                                                      blockController
                                                                          .text
                                                                          .length));
                                                    },
                                                    decoration:
                                                        decfunction('Block')),
                                              ),
                                              SizedBox(height: HEIGHT * 0.0128,),
                                              SizedBox(
                                                height: HEIGHT * 0.0768156,
                                                child: TextFormField(
                                                    style: TextStyle(color: kWhite),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "remember your floor number correctly";
                                                      }
                                                      return null;
                                                    },
                                                    controller: floorController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    onChanged: (v) {
                                                      floorController.text = v;
                                                      hostel.floor = v;
                                                      floorController.selection =
                                                          TextSelection.fromPosition(
                                                              TextPosition(
                                                                  offset:
                                                                      floorController
                                                                          .text
                                                                          .length));
                                                    },
                                                    decoration:
                                                        decfunction('Floor')),
                                              ),
                                            ],
                                          ),
                                        )
*/
