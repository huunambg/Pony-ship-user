import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import '../NavigatorPages/adminchatpage.dart';
import '../NavigatorPages/editprofile.dart';
import '../NavigatorPages/faq.dart';
import '../NavigatorPages/favourite.dart';
import '../NavigatorPages/history.dart';
import '../NavigatorPages/makecomplaint.dart';
import '../NavigatorPages/notification.dart';
import '../NavigatorPages/referral.dart';
import '../NavigatorPages/selectlanguage.dart';
import '../NavigatorPages/sos.dart';
import '../NavigatorPages/walletpage.dart';
import '../onTripPage/map_page.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  darkthemefun() async {
    if (isDarkTheme) {
      isDarkTheme = false;
      page = Colors.white;
      textColor = Colors.black;
      buttonColor = theme;
      loaderColor = theme;
      hintColor = const Color(0xff12121D).withOpacity(0.3);
    } else {
      isDarkTheme = true;
      page = const Color(0xFF3D3D3D);
      textColor = Colors.white.withOpacity(0.9);
      buttonColor = Colors.white;
      loaderColor = Colors.white;
      hintColor = Colors.white.withOpacity(0.3);
    }
    await getDetailsOfDevice();

    pref.setBool('isDarkTheme', isDarkTheme);

    valueNotifierHome.incrementNotifier();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: valueNotifierHome.value,
        builder: (context, value, child) {
          return SizedBox(
            width: media.width * 0.8,
            child: Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Drawer(
                  backgroundColor: page,
                  child: SizedBox(
                    width: media.width * 0.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: media.width * 0.05 +
                                        MediaQuery.of(context).padding.top,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: media.width * 0.2,
                                          width: media.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userDetails[
                                                          'profile_picture']),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: media.width * 0.025,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: media.width * 0.45,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: media.width * 0.3,
                                                    child: MyText(
                                                      text: userDetails['name'],
                                                      size: media.width *
                                                          eighteen,
                                                      fontweight:
                                                          FontWeight.w600,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      var val = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const EditProfile()));
                                                      if (val) {
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                          media.width * 0.01),
                                                      decoration: BoxDecoration(
                                                          color: textColor
                                                              .withOpacity(0.1),
                                                          border: Border.all(
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.15)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(media
                                                                          .width *
                                                                      0.01)),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit,
                                                              size:
                                                                  media.width *
                                                                      fourteen,
                                                              color: textColor),
                                                          MyText(
                                                              text: languages[
                                                                      choosenLanguage]
                                                                  ['text_edit'],
                                                              size:
                                                                  media.width *
                                                                      twelve,
                                                              color: textColor)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: media.width * 0.01,
                                            ),
                                            SizedBox(
                                              width: media.width * 0.45,
                                              child: MyText(
                                                text: userDetails['mobile'],
                                                size: media.width * fourteen,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: media.width * 0.05),
                                    width: media.width * 0.7,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: media.width * 0.025),
                                          child: Row(
                                            children: [
                                              MyText(
                                                text: languages[choosenLanguage]
                                                        ['text_account']
                                                    .toString()
                                                    .toUpperCase(),
                                                size: media.width * fourteen,
                                                fontweight: FontWeight.w700,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //My orders

                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const History()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_my_orders'],
                                          image: 'assets/images/history.png',
                                        ),

                                        ValueListenableBuilder(
                                            valueListenable:
                                                valueNotifierNotification.value,
                                            builder: (context, value, child) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NotificationPage()));
                                                  setState(() {
                                                    userDetails[
                                                        'notifications_count'] = 0;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: media.width * 0.025),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/notification.png',
                                                            fit: BoxFit.contain,
                                                            width: media.width *
                                                                0.075,
                                                            color: textColor
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          SizedBox(
                                                            width: media.width *
                                                                0.02,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: (userDetails[
                                                                            'notifications_count'] ==
                                                                        0)
                                                                    ? media.width *
                                                                        0.55
                                                                    : media.width *
                                                                        0.495,
                                                                child: MyText(
                                                                  text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_notification']
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  size: media
                                                                          .width *
                                                                      sixteen,
                                                                  color: textColor
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  (userDetails[
                                                                              'notifications_count'] ==
                                                                          0)
                                                                      ? Container()
                                                                      : Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                buttonColor,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            userDetails['notifications_count'].toString(),
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: media.width * fourteen, color: (isDarkTheme) ? Color.fromARGB(255, 230, 27, 27) : buttonText),
                                                                          ),
                                                                        ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward_ios_outlined,
                                                                    size: media
                                                                            .width *
                                                                        0.05,
                                                                    color: textColor
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: media.width *
                                                              0.01,
                                                          left: media.width *
                                                              0.09,
                                                        ),
                                                        child: Container(
                                                          color: textColor
                                                              .withOpacity(0.1),
                                                          height: 1,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),

                                        ValueListenableBuilder(
                                            valueListenable:
                                                valueNotifierChat.value,
                                            builder: (context, value, child) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AdminChatPage()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: media.width * 0.025),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.chat,
                                                              size:
                                                                  media.width *
                                                                      0.075,
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.8)),
                                                          SizedBox(
                                                            width: media.width *
                                                                0.025,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: (unSeenChatCount == '0')
                                                                    ? media.width *
                                                                        0.55
                                                                    : media.width *
                                                                        0.495,
                                                                child: MyText(
                                                                  text: languages[
                                                                          choosenLanguage]
                                                                      [
                                                                      'text_chat_us'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  size: media
                                                                          .width *
                                                                      sixteen,
                                                                  color: textColor
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  (unSeenChatCount ==
                                                                          '0')
                                                                      ? Container()
                                                                      : Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                buttonColor,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            unSeenChatCount,
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: media.width * fourteen, color: (isDarkTheme) ? Colors.black : buttonText),
                                                                          ),
                                                                        ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward_ios_outlined,
                                                                    size: media
                                                                            .width *
                                                                        0.05,
                                                                    color: textColor
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: media.width *
                                                              0.01,
                                                          left: media.width *
                                                              0.09,
                                                        ),
                                                        child: Container(
                                                          color: textColor
                                                              .withOpacity(0.1),
                                                          height: 1,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),

                                        //wallet page
                                        if (userDetails[
                                                'show_wallet_feature_on_mobile_app'] ==
                                            "1")
                                          NavMenu(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const WalletPage()));
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_enable_wallet'],
                                            image:
                                                'assets/images/walletIcon.png',
                                          ),

                                        //FAQ
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Faq()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_faq'],
                                          image: 'assets/images/faq.png',
                                        ),

                                        //sos
                                        NavMenu(
                                          onTap: () async {
                                            var nav = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Sos()));
                                            if (nav) {
                                              setState(() {});
                                            }
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_sos'],
                                          image: 'assets/images/sos.png',
                                        ),

                                        //saved address
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Favorite()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_favourites'],
                                          icon: Icons.bookmark,
                                        ),

                                        //select language
                                        NavMenu(
                                          onTap: () async {
                                            var nav = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SelectLanguage()));
                                            if (nav) {
                                              setState(() {});
                                            }
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_change_language'],
                                          image:
                                              'assets/images/changeLanguage.png',
                                        ),

                                        //Make Complaint
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MakeComplaint(
                                                            fromPage: 1)));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_make_complaints'],
                                          image:
                                              'assets/images/makecomplaint.png',
                                        ),

                                        //delete account
                                        NavMenu(
                                          onTap: () {
                                            setState(() {
                                              deleteAccount = true;
                                            });
                                            valueNotifierHome
                                                .incrementNotifier();
                                            Navigator.pop(context);
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_delete_account'],
                                          icon: Icons.delete_forever,
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(
                                              top: media.width * 0.05),
                                          child: Row(
                                            children: [
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_general'],
                                                size: media.width * fourteen,
                                                fontweight: FontWeight.w700,
                                              ),
                                            ],
                                          ),
                                        ),

                                        //privacy policy
                                        NavMenu(
                                          onTap: () {
                                            openBrowser('${url}privacy');
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_privacy'],
                                          image:
                                              'assets/images/privacy_policy.png',
                                        ),

                                        //referral page
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ReferralPage()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_enable_referal'],
                                          image: 'assets/images/referral.png',
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      darkthemefun();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: media.width * 0.025),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            isDarkTheme
                                                ? Icons.brightness_4_outlined
                                                : Icons.brightness_3_rounded,
                                            size: media.width * 0.075,
                                            color: textColor.withOpacity(0.8),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.025,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: media.width * 0.46,
                                                  child: Text(
                                                    languages[choosenLanguage]
                                                        ['text_select_theme'],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: media.width *
                                                            sixteen,
                                                        color: textColor
                                                            .withOpacity(0.8)),
                                                  )),
                                              Switch(
                                                  value: isDarkTheme,
                                                  onChanged: (toggle) async {
                                                    darkthemefun();
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              logout = true;
                            });
                            valueNotifierHome.incrementNotifier();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: media.width * 0.25,
                            ),
                            height: media.width * 0.13,
                            width: media.width * 0.8,
                            color: Colors.grey.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: (languageDirection == 'ltr')
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Icon(Icons.logout,
                                    size: media.width * 0.05, color: textColor),
                                SizedBox(
                                  width: media.width * 0.025,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                      ['text_sign_out'],
                                  size: media.width * sixteen,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
