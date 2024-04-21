import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import 'dart:math' as math;
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';
import 'agreement.dart';
import 'namepage.dart';
import 'otp_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

//code as int for getting phone dial code of choosen country
String phnumber = ''; // phone number as string entered in input field
// String phone = '';
List pages = [1, 2, 3, 4];
int currentPage = 0;
bool loginLoading = true;
var value = 0;
bool isfromomobile = true;
bool isLoginemail = false;

class _LoginState extends State<Login> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  // final _pinPutController2 = TextEditingController();
  dynamic aController;
  String _error = '';
  // bool _resend = false;

  String get timerString {
    Duration duration = aController.duration * aController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  bool terms = true; //terms and conditions true or false

  @override
  void initState() {
    currentPage = 0;
    controller.text = '';
    aController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    countryCode();
    super.initState();
  }

  countryCode() async {
    isverifyemail = false;
    isLoginemail = false;
    isfromomobile = true;
    var result = await getCountryCode(context);
    if (result == 'success') {
      setState(() {
        loginLoading = false;
      });
    } else {
      setState(() {
        loginLoading = false;
      });
    }
  }

  //navigate
  navigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Otp()));
  }

  var verifyEmailError = '';
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: ValueListenableBuilder(
              valueListenable: valueNotifierLogin.value,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      color: page,
                      padding: EdgeInsets.only(
                          // top: media.width * 0.02,
                          //  MediaQuery.of(context).padding.top,
                          left: media.width * 0.05,
                          right: media.width * 0.05),
                      // height: media.height * 1,
                      width: media.width * 1,
                      height: media.height * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: media.height * 0.09),
                          if (currentPage != 0)
                            InkWell(
                                onTap: () {
                                  if (currentPage == 2) {
                                    setState(() {
                                      controller.text = '';
                                      currentPage = 0;
                                      isverifyemail = false;
                                      isLoginemail = false;
                                      isfromomobile = true;
                                    });
                                  } else if (currentPage == 1) {
                                    if (currentPage == 1 && isverifyemail) {
                                      setState(() {
                                        isfromomobile = false;
                                        currentPage = 2;
                                      });
                                    } else {
                                      setState(() {
                                        currentPage = currentPage - 1;
                                      });
                                    }
                                  } else {
                                    if (currentPage == 3 &&
                                        isverifyemail &&
                                        isLoginemail) {
                                      setState(() {
                                        isfromomobile = false;
                                      });
                                    }
                                    setState(() {
                                      currentPage = currentPage - 1;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: textColor,
                                  size: media.height * eighteen,
                                )),
                          SizedBox(
                            height: media.height * 0.05,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            margin: EdgeInsets.only(
                                left: (languageDirection == 'rtl')
                                    ? 0
                                    : (media.width * 0.25) * currentPage,
                                right: (languageDirection == 'ltr')
                                    ? 0
                                    : (media.width * 0.25) * currentPage),
                            child: Image.asset(
                              (languageDirection == 'ltr')
                                  ? 'assets/images/car.png'
                                  : 'assets/images/car_rtl.png',
                              color:
                                  (isDarkTheme) ? Colors.white : Colors.black,
                              width: media.width * 0.15,
                            ),
                          ),
                          Row(
                            children: pages
                                .asMap()
                                .map((key, value) {
                                  return MapEntry(
                                    key,
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? buttonColor
                                                  : buttonColor
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xffFFFFFF)
                                                  : const Color(0xffFFFFFF)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xffFFFFFF)
                                                  : const Color(0xffFFFFFF)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? buttonColor
                                                  : buttonColor
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? buttonColor
                                                  : buttonColor
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xffFFFFFF)
                                                  : const Color(0xffFFFFFF)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xffFFFFFF)
                                                  : const Color(0xffFFFFFF)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? buttonColor
                                                  : buttonColor
                                                      .withOpacity(0.4),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              height:
                                                  (media.width * 0.9 / 4) / 8,
                                              width:
                                                  (media.width * 0.9 / 4) / 8,
                                              color: (currentPage >= key)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xff000000)
                                                      .withOpacity(0.4),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                          SizedBox(
                            height: media.height * 0.05,
                          ),
                          (countries.isNotEmpty && currentPage == 0)
                              ? (isLoginemail == false)
                                  ? Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_what_mobilenum'],
                                          size: media.width * twenty,
                                          fontweight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: media.height * 0.02,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          height: 55,
                                          width: media.width * 0.9,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: textColor),
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (countries.isNotEmpty) {
                                                    //dialod box for select country for dial code
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          var searchVal = '';
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                page,
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            content: StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                width: media
                                                                        .width *
                                                                    0.9,
                                                                color: page,
                                                                child:
                                                                    Directionality(
                                                                  textDirection: (languageDirection ==
                                                                          'rtl')
                                                                      ? TextDirection
                                                                          .rtl
                                                                      : TextDirection
                                                                          .ltr,
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20),
                                                                        height:
                                                                            40,
                                                                        width: media.width *
                                                                            0.9,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            border: Border.all(color: Colors.grey, width: 1.5)),
                                                                        child:
                                                                            TextField(
                                                                          decoration: InputDecoration(
                                                                              contentPadding: (languageDirection == 'rtl') ? EdgeInsets.only(bottom: media.width * 0.035) : EdgeInsets.only(bottom: media.width * 0.04),
                                                                              border: InputBorder.none,
                                                                              hintText: languages[choosenLanguage]['text_search'],
                                                                              hintStyle: GoogleFonts.poppins(fontSize: media.width * sixteen, color: hintColor)),
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: media.width * sixteen,
                                                                              color: textColor),
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(() {
                                                                              searchVal = val;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      Expanded(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: countries
                                                                                .asMap()
                                                                                .map((i, value) {
                                                                                  return MapEntry(
                                                                                      i,
                                                                                      SizedBox(
                                                                                        width: media.width * 0.9,
                                                                                        child: (searchVal == '' && countries[i]['flag'] != null)
                                                                                            ? InkWell(
                                                                                                onTap: () {
                                                                                                  setState(() {
                                                                                                    phcode = i;
                                                                                                  });
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Container(
                                                                                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                                  color: page,
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Image.network(countries[i]['flag']),
                                                                                                          SizedBox(
                                                                                                            width: media.width * 0.02,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: media.width * 0.4,
                                                                                                            child: MyText(
                                                                                                              text: countries[i]['name'],
                                                                                                              size: media.width * sixteen,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      MyText(text: countries[i]['dial_code'], size: media.width * sixteen)
                                                                                                    ],
                                                                                                  ),
                                                                                                ))
                                                                                            : (countries[i]['flag'] != null && countries[i]['name'].toLowerCase().contains(searchVal.toLowerCase()))
                                                                                                ? InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        phcode = i;
                                                                                                      });
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                                      color: page,
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              Image.network(countries[i]['flag']),
                                                                                                              SizedBox(
                                                                                                                width: media.width * 0.02,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                width: media.width * 0.4,
                                                                                                                child: MyText(text: countries[i]['name'], size: media.width * sixteen),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          MyText(text: countries[i]['dial_code'], size: media.width * sixteen)
                                                                                                        ],
                                                                                                      ),
                                                                                                    ))
                                                                                                : Container(),
                                                                                      ));
                                                                                })
                                                                                .values
                                                                                .toList(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        });
                                                  } else {
                                                    getCountryCode(context);
                                                  }
                                                  setState(() {});
                                                },
                                                //input field
                                                child: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.network(
                                                          countries[phcode]
                                                              ['flag']),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.02,
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 28,
                                                        color: textColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                width: 1,
                                                height: 55,
                                                color: underline,
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  height: 50,
                                                  child: TextFormField(
                                                    textAlign: TextAlign.start,
                                                    controller: controller,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        phnumber =
                                                            controller.text;
                                                      });
                                                      if (controller
                                                              .text.length ==
                                                          countries[phcode][
                                                              'dial_max_length']) {
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      }
                                                    },
                                                    maxLength: countries[phcode]
                                                        ['dial_max_length'],
                                                    style: choosenLanguage ==
                                                            'ar'
                                                        ? GoogleFonts.cairo(
                                                            color: textColor,
                                                            fontSize:
                                                                media.width *
                                                                    sixteen,
                                                            letterSpacing: 1)
                                                        : GoogleFonts.poppins(
                                                            color: textColor,
                                                            fontSize:
                                                                media.width *
                                                                    sixteen,
                                                            letterSpacing: 1),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 12),
                                                        child: MyText(
                                                          text: countries[
                                                                      phcode]
                                                                  ['dial_code']
                                                              .toString(),
                                                          size: media.width *
                                                              sixteen,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          choosenLanguage ==
                                                                  'ar'
                                                              ? GoogleFonts
                                                                  .cairo(
                                                                  color: textColor
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontSize: media
                                                                          .width *
                                                                      sixteen,
                                                                )
                                                              : GoogleFonts
                                                                  .poppins(
                                                                  color: textColor
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontSize: media
                                                                          .width *
                                                                      sixteen,
                                                                ),
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: media.height * 0.02),
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_you_get_otp'],
                                          size: media.width * fourteen,
                                          color: textColor.withOpacity(0.5),
                                        ),
                                        SizedBox(height: media.height * 0.03),
                                        (isemailmodule == '1')
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.clear();
                                                      if (isLoginemail ==
                                                          false) {
                                                        setState(() {
                                                          _error = '';
                                                          isLoginemail = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _error = '';
                                                          isLoginemail = false;
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      languages[choosenLanguage]
                                                              [
                                                              'text_continue_with'] +
                                                          ' ' +
                                                          languages[
                                                                  choosenLanguage]
                                                              ['text_email'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: textColor
                                                            .withOpacity(0.7),
                                                        fontSize: media.width *
                                                            sixteen,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          media.width * 0.02),
                                                  Icon(Icons.email_outlined,
                                                      size: media.width *
                                                          eighteen,
                                                      color: textColor
                                                          .withOpacity(0.7)),
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: media.height * 0.03,
                                        ),
                                        if (_error != '')
                                          Column(
                                            children: [
                                              SizedBox(
                                                  width: media.width * 0.9,
                                                  child: MyText(
                                                    text: _error,
                                                    color: Colors.red,
                                                    size:
                                                        media.width * fourteen,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              SizedBox(
                                                height: media.width * 0.025,
                                              )
                                            ],
                                          ),
                                        (controller.text.length >=
                                                countries[phcode]
                                                    ['dial_min_length'])
                                            ? Container(
                                                width: media.width * 1 -
                                                    media.width * 0.08,
                                                alignment: Alignment.center,
                                                child: Button(
                                                  onTap: () async {
                                                    if (controller
                                                            .text.length >=
                                                        countries[phcode][
                                                            'dial_min_length']) {
                                                      _error = '';
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      setState(() {
                                                        loginLoading = true;
                                                      });
                                                      //check if otp is true or false
                                                      var val = await otpCall();
                                                      //otp is true
                                                      if (val.value == true) {
                                                        phoneAuthCheck = true;
                                                        await phoneAuth(countries[
                                                                    phcode]
                                                                ['dial_code'] +
                                                            phnumber);
                                                        value = 0;
                                                        currentPage = 1;
                                                        loginLoading = false;
                                                        setState(() {});
                                                      }
                                                      //otp is false
                                                      else if (val.value ==
                                                          false) {
                                                        phoneAuthCheck = false;
                                                        currentPage = 1;
                                                        loginLoading = false;
                                                        setState(() {});
                                                      }
                                                    }
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_login'],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_what_email'],
                                          size: media.width * twenty,
                                          fontweight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: media.height * 0.02,
                                        ),
                                        Container(
                                            height: media.width * 0.13,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: (isDarkTheme == true)
                                                        ? textColor
                                                            .withOpacity(0.4)
                                                        : underline),
                                                color: (isDarkTheme == true)
                                                    ? page
                                                    : const Color(0xffF8F8F8)),
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: MyTextField(
                                              textController: controller,
                                              hinttext:
                                                  languages[choosenLanguage]
                                                      ['text_enter_email'],
                                              onTap: (val) {
                                                setState(() {
                                                  email = controller.text;
                                                });
                                              },
                                            )),
                                        SizedBox(height: media.height * 0.02),
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_you_get_otp'],
                                          size: media.width * fourteen,
                                          color: textColor.withOpacity(0.5),
                                        ),
                                        SizedBox(height: media.height * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.clear();
                                                if (isLoginemail == false) {
                                                  setState(() {
                                                    _error = '';
                                                    isLoginemail = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _error = '';
                                                    isLoginemail = false;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                languages[choosenLanguage]
                                                        ['text_continue_with'] +
                                                    ' ' +
                                                    languages[choosenLanguage]
                                                        ['text_mob_num'],
                                                style: GoogleFonts.poppins(
                                                  color: textColor
                                                      .withOpacity(0.7),
                                                  fontSize:
                                                      media.width * sixteen,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: media.width * 0.03,
                                            ),
                                            Icon(Icons.call,
                                                size: media.width * eighteen,
                                                color:
                                                    textColor.withOpacity(0.7)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: media.height * 0.05,
                                        ),
                                        if (_error != '')
                                          Column(
                                            children: [
                                              SizedBox(
                                                  width: media.width * 0.9,
                                                  child: MyText(
                                                    text: _error,
                                                    color: Colors.red,
                                                    size:
                                                        media.width * fourteen,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              SizedBox(
                                                height: media.width * 0.025,
                                              )
                                            ],
                                          ),
                                        (controller.text.isNotEmpty)
                                            ? Container(
                                                width: media.width * 1,
                                                alignment: Alignment.center,
                                                child: Button(
                                                    onTap: () async {
                                                      setState(() {
                                                        _error = '';
                                                      });
                                                      String pattern =
                                                          r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])*$";
                                                      RegExp regex =
                                                          RegExp(pattern);
                                                      if (regex.hasMatch(
                                                          controller.text)) {
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();

                                                        setState(() {
                                                          verifyEmailError = '';
                                                          loginLoading = true;
                                                        });

                                                        phoneAuthCheck = true;
                                                        await sendOTPtoEmail(
                                                            email);
                                                        value = 1;
                                                        isfromomobile = false;
                                                        currentPage = 1;

                                                        // navigate();

                                                        setState(() {
                                                          loginLoading = false;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          loginLoading = false;
                                                          _error = languages[
                                                                  choosenLanguage]
                                                              [
                                                              'text_email_validation'];
                                                        });
                                                      }
                                                    },
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_login']))
                                            : Container(),
                                      ],
                                    )
                              : (currentPage == 1)
                                  ? const Expanded(child: Otp())
                                  : (currentPage == 2)
                                      ? const Expanded(child: NamePage())
                                      : (currentPage == 3)
                                          ? const Expanded(
                                              child: AggreementPage())
                                          : Container(),
                        ],
                      ),
                    ),

                    //No internet
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(onTap: () {
                              setState(() {
                                loginLoading = true;
                                internet = true;
                                countryCode();
                              });
                            }))
                        : Container(),

                    //loader
                    (loginLoading == true)
                        ? const Positioned(top: 0, child: Loading())
                        : Container()
                  ],
                );
              })),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
