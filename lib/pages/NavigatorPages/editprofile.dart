import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

dynamic imageFile;

class _EditProfileState extends State<EditProfile> {
  ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  // ignore: prefer_final_fields
  String _error = '';
  String _permission = '';
  bool _pickImage = false;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobilenum = TextEditingController();
  bool isotppage = false;
  TextEditingController pinText = TextEditingController();
  bool chooseWorkArea = false;
  String _otperror = '';
//gallery permission
  getGalleryPermission() async {
    dynamic status;
    if (platform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
        }

        /// use [Permissions.storage.status]
      } else {
        status = await Permission.photos.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.photos.request();
        }
      }
    } else {
      status = await Permission.photos.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.photos.request();
      }
    }
    return status;
  }

//camera permission
  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.camera.request();
    }
    return status;
  }

//pick image from gallery
  pickImageFromGallery() async {
    var permission = await getGalleryPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        imageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noPhotos';
      });
    }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission = await getCameraPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      setState(() {
        imageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  //navigate pop
  pop() {
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    isotppage = false;
    countrycode();
    super.initState();
  }

  countrycode() {
    firstname.text = userDetails['name'].toString().split(' ')[0];
    lastname.text = (userDetails['name'].toString().split(' ').length > 1)
        ? userDetails['name'].toString().split(' ')[1]
        : '';
    mobilenum.text = userDetails['mobile'];
    email.text = userDetails['email'];
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(media.width * 0.05),
              height: media.height * 1,
              width: media.width * 1,
              color: page,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: media.width * 0.05),
                              width: media.width * 1,
                              alignment: Alignment.center,
                              child: MyText(
                                text: languages[choosenLanguage]
                                    ['text_editprofile'],
                                size: media.width * twenty,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Positioned(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back_ios,
                                        color: textColor)))
                          ],
                        ),
                        SizedBox(height: media.width * 0.05),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _pickImage = true;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: media.width * 0.3,
                                width: media.width * 0.3,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: page,
                                    image: (imageFile == null)
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              userDetails['profile_picture'],
                                            ),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: FileImage(File(imageFile)),
                                            fit: BoxFit.cover)),
                              ),
                              Positioned(
                                  right: media.width * 0.04,
                                  bottom: media.width * 0.02,
                                  child: Container(
                                    height: media.width * 0.05,
                                    width: media.width * 0.05,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff898989)),
                                    child: Icon(
                                      Icons.edit,
                                      color: topBar,
                                      size: media.width * 0.04,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        SizedBox(
                          width: media.width * 0.9,
                          child: MyText(
                            text: languages[choosenLanguage]['text_name'],
                            size: media.width * sixteen,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: (isDarkTheme == true)
                                            ? textColor.withOpacity(0.4)
                                            : underline),
                                    color: (isDarkTheme == true)
                                        ? Colors.black
                                        : const Color(0xffF8F8F8)),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: TextField(
                                  controller: firstname,
                                  textDirection: (choosenLanguage == 'iw' ||
                                          choosenLanguage == 'ur' ||
                                          choosenLanguage == 'ar')
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: languages[choosenLanguage]
                                        ['text_first_name'],
                                    hintStyle: choosenLanguage == 'ar'
                                        ? GoogleFonts.cairo(
                                            fontSize: media.width * fourteen,
                                            fontWeight: FontWeight.normal,
                                            color: textColor.withOpacity(0.3),
                                            letterSpacing: 1)
                                        : GoogleFonts.poppins(
                                            fontSize: media.width * fourteen,
                                            fontWeight: FontWeight.normal,
                                            color: textColor.withOpacity(0.3),
                                            letterSpacing: 1),
                                  ),
                                  style: choosenLanguage == 'ar'
                                      ? GoogleFonts.cairo(
                                          color: textColor,
                                          fontSize: media.width * fourteen,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 1)
                                      : GoogleFonts.poppins(
                                          color: textColor,
                                          fontSize: media.width * fourteen,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 1),
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: media.height * 0.02,
                            ),
                            Expanded(
                              child: Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: (isDarkTheme == true)
                                            ? textColor.withOpacity(0.4)
                                            : underline),
                                    color: (isDarkTheme == true)
                                        ? Colors.black
                                        : const Color(0xffF8F8F8)),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: TextField(
                                  textDirection: (choosenLanguage == 'iw' ||
                                          choosenLanguage == 'ur' ||
                                          choosenLanguage == 'ar')
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  controller: lastname,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: languages[choosenLanguage]
                                        ['text_last_name'],
                                    hintStyle: choosenLanguage == 'ar'
                                        ? GoogleFonts.cairo(
                                            fontSize: media.width * fourteen,
                                            fontWeight: FontWeight.normal,
                                            color: textColor.withOpacity(0.3),
                                          )
                                        : GoogleFonts.poppins(
                                            fontSize: media.width * fourteen,
                                            fontWeight: FontWeight.normal,
                                            color: textColor.withOpacity(0.3),
                                          ),
                                  ),
                                  style: choosenLanguage == 'ar'
                                      ? GoogleFonts.cairo(
                                          color: textColor,
                                          fontSize: media.width * fourteen,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 1)
                                      : GoogleFonts.poppins(
                                          color: textColor,
                                          fontSize: media.width * fourteen,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 1),
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                        SizedBox(
                          width: media.width * 0.9,
                          child: MyText(
                            text: languages[choosenLanguage]['text_mob_num'],
                            size: media.width * sixteen,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                        Container(
                          height: media.width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: (isDarkTheme == true)
                                      ? textColor.withOpacity(0.4)
                                      : underline),
                              color: (isDarkTheme == true)
                                  ? Colors.black
                                  : const Color(0xffF8F8F8)),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextField(
                            controller: mobilenum,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            decoration: InputDecoration(
                              counterText: '',
                              // prefixText: '+962 ',
                              prefixStyle: choosenLanguage == 'ar'
                                  ? GoogleFonts.cairo(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor,
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor,
                                    ),
                              border: InputBorder.none,
                              hintText: languages[choosenLanguage]
                                  ['text_enter_phone_number'],
                              hintStyle: choosenLanguage == 'ar'
                                  ? GoogleFonts.cairo(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor.withOpacity(0.3),
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor.withOpacity(0.3),
                                    ),
                            ),
                            style: choosenLanguage == 'ar'
                                ? GoogleFonts.cairo(
                                    color: textColor,
                                    fontSize: media.width * fourteen,
                                    fontWeight: FontWeight.normal,
                                  )
                                : GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: media.width * fourteen,
                                    fontWeight: FontWeight.normal,
                                  ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                        SizedBox(
                          width: media.width * 0.9,
                          child: MyText(
                            text: languages[choosenLanguage]['text_email'],
                            size: media.width * sixteen,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                        Container(
                          height: media.width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: (isDarkTheme == true)
                                      ? textColor.withOpacity(0.4)
                                      : underline),
                              color: (isDarkTheme == true)
                                  ? Colors.black
                                  : const Color(0xffF8F8F8)),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: languages[choosenLanguage]
                                  ['text_enter_email'],
                              hintStyle: choosenLanguage == 'ar'
                                  ? GoogleFonts.cairo(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor.withOpacity(0.3),
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: media.width * fourteen,
                                      fontWeight: FontWeight.normal,
                                      color: textColor.withOpacity(0.3),
                                    ),
                            ),
                            style: choosenLanguage == 'ar'
                                ? GoogleFonts.cairo(
                                    color: textColor,
                                    fontSize: media.width * fourteen,
                                    fontWeight: FontWeight.normal,
                                  )
                                : GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: media.width * fourteen,
                                    fontWeight: FontWeight.normal,
                                  ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                  if (_error != '')
                    Container(
                      width: media.width * 0.9,
                      padding: EdgeInsets.only(
                          top: media.width * 0.02, bottom: media.width * 0.02),
                      child: MyText(
                        text: _error,
                        size: media.width * twelve,
                        color: textColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(
                      width: media.width * 0.9,
                      child: Button(
                          onTap: () async {
                            setState(() {
                              _error = '';
                            });
                            String pattern =
                                r"^[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])*$";
                            RegExp regex = RegExp(pattern);
                            if (regex.hasMatch(email.text)) {
                              setState(() {
                                _isLoading = true;
                              });
                              dynamic nav;

                              nav = await updateProfile(
                                  '${firstname.text} ${lastname.text}',
                                  email.text);

                              if (nav != 'success') {
                                _error = nav.toString();
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context, true);
                              }
                            } else {
                              setState(() {
                                _error = languages[choosenLanguage]
                                    ['text_email_validation'];
                              });
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          text: languages[choosenLanguage]['text_confirm']))
                ],
              ),
            ),

            //pick image bar
            (_pickImage == true)
                ? Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _pickImage = false;
                        });
                      },
                      child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 1,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  border: Border.all(
                                    color: borderLines,
                                    width: 1.2,
                                  ),
                                  color: page),
                              child: Column(
                                children: [
                                  Container(
                                    height: media.width * 0.02,
                                    width: media.width * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          media.width * 0.01),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickImageFromCamera();
                                            },
                                            child: Container(
                                                height: media.width * 0.171,
                                                width: media.width * 0.171,
                                                decoration: BoxDecoration(
                                                    color: topBar,
                                                    border: Border.all(
                                                        color: borderLines,
                                                        width: 1.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: media.width * 0.064,
                                                  color: textColor,
                                                )),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.02,
                                          ),
                                          MyText(
                                            text: languages[choosenLanguage]
                                                ['text_camera'],
                                            size: media.width * ten,
                                            color: (isDarkTheme == true)
                                                ? textColor.withOpacity(0.4)
                                                : const Color(0xff666666),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickImageFromGallery();
                                            },
                                            child: Container(
                                                height: media.width * 0.171,
                                                width: media.width * 0.171,
                                                decoration: BoxDecoration(
                                                    color: topBar,
                                                    border: Border.all(
                                                        color: borderLines,
                                                        width: 1.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  size: media.width * 0.064,
                                                )),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.02,
                                          ),
                                          MyText(
                                            text: languages[choosenLanguage]
                                                ['text_gallery'],
                                            size: media.width * ten,
                                            color: (isDarkTheme == true)
                                                ? textColor.withOpacity(0.4)
                                                : const Color(0xff666666),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                : Container(),

            //popup for denied permission
            (_permission != '')
                ? Positioned(
                    child: Container(
                    height: media.height * 1,
                    width: media.width * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: media.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _permission = '';
                                    _pickImage = false;
                                  });
                                },
                                child: Container(
                                  height: media.width * 0.1,
                                  width: media.width * 0.1,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: page),
                                  child: const Icon(Icons.cancel_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Container(
                          padding: EdgeInsets.all(media.width * 0.05),
                          width: media.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: page,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    color: Colors.black.withOpacity(0.2))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: media.width * 0.8,
                                  child: MyText(
                                    text: (_permission == 'noPhotos')
                                        ? languages[choosenLanguage]
                                            ['text_open_photos_setting']
                                        : languages[choosenLanguage]
                                            ['text_open_camera_setting'],
                                    size: media.width * sixteen,
                                    fontweight: FontWeight.w600,
                                  )),
                              SizedBox(height: media.width * 0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        await openAppSettings();
                                      },
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_open_settings'],
                                        size: media.width * sixteen,
                                        fontweight: FontWeight.w600,
                                      )),
                                  InkWell(
                                      onTap: () async {
                                        (_permission == 'noCamera')
                                            ? pickImageFromCamera()
                                            : pickImageFromGallery();
                                        setState(() {
                                          _permission = '';
                                        });
                                      },
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_done'],
                                        size: media.width * sixteen,
                                        color: buttonColor,
                                        fontweight: FontWeight.w600,
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                : Container(),

            if (isotppage == true)
              Positioned(
                  child: Container(
                height: media.height * 1,
                width: media.width * 1,
                color: Colors.transparent.withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: media.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isotppage = false;
                              });
                            },
                            child: Container(
                              height: media.width * 0.1,
                              width: media.width * 0.1,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: page),
                              child: const Icon(Icons.cancel_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.025,
                    ),
                    Container(
                      width: media.width * 0.9,
                      padding: EdgeInsets.all(media.width * 0.05),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: page),
                      child: Column(
                        children: [
                          SizedBox(
                            width: media.width * 0.8,
                            child: MyText(
                              text:
                                  '${languages[choosenLanguage]['text_enter_otp']} +962 ${mobilenum.text}',
                              size: media.width * fourteen,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: media.width * 0.025,
                          ),
                          SizedBox(
                            width: media.width * 0.8,
                            child: Pinput(
                              length: 6,
                              onChanged: (val) {},
                              controller: pinText,
                            ),
                          ),
                          if (_otperror != '')
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                          Container(
                            width: media.width * 0.8,
                            padding:
                                EdgeInsets.only(bottom: media.width * 0.025),
                            child: MyText(
                              text: _otperror,
                              size: media.width * twelve,
                              color: textColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Button(
                              onTap: () async {
                                if (pinText.text.length == 6) {
                                  setState(() {
                                    _otperror = '';
                                    _isLoading = true;
                                  });
                                  try {
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: verId,
                                            smsCode: pinText.text);

                                    // Sign the user in (or link) with the credential
                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);
                                    await updateProfile(
                                      '${firstname.text} ${lastname.text}',
                                      email.text,
                                    );
                                  } on FirebaseAuthException catch (error) {
                                    if (error.code ==
                                        'invalid-verification-code') {
                                      setState(() {
                                        pinText.clear();
                                        _otperror = languages[choosenLanguage]
                                            ['text_otp_error'];
                                      });
                                    }
                                  }
                                  setState(() {
                                    pinText.clear();
                                    isotppage = false;
                                    _isLoading = false;
                                  });
                                } else {
                                  phoneAuth('+962 ${mobilenum.text}');
                                }
                              },
                              text: (pinText.text.length == 6)
                                  ? languages[choosenLanguage]['text_confirm']
                                  : languages[choosenLanguage]
                                      ['text_resend_code']),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              )),
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        setState(() {
                          internetTrue();
                        });
                      },
                    ))
                : Container(),

            //loader
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : Container(),
          ],
        ),
      ),
    );
  }
}
