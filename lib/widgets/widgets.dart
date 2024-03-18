import 'package:flutter/material.dart';
import '../functions/functions.dart';
import '../pages/NavigatorPages/walletpage.dart';
import '../styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../translations/translation.dart';

//button style

// ignore: must_be_immutable
class Button extends StatefulWidget {
  dynamic onTap;
  final String text;
  dynamic color;
  dynamic borcolor;
  dynamic textcolor;
  dynamic width;
  dynamic height;
  dynamic borderRadius;
  dynamic fontweight;
  // ignore: use_key_in_widget_constructors
  Button(
      {required this.onTap,
      required this.text,
      this.color,
      this.borcolor,
      this.textcolor,
      this.width,
      this.height,
      this.fontweight,
      this.borderRadius});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
// F9C27D
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: widget.color ?? buttonColor,
            border: Border.all(
                color: (widget.borcolor != null) ? widget.borcolor : page),
            borderRadius: BorderRadius.all(Radius.circular(
                (widget.borderRadius == null) ? 80.0 : widget.borderRadius))),
        child: Container(
          height: widget.height ?? media.width * 0.12,
          width: (widget.width != null) ? widget.width : null,
          padding: EdgeInsets.only(
              left: media.width * twenty, right: media.width * twenty),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              widget.text,
              style: choosenLanguage == 'ar'
                  ? GoogleFonts.cairo(
                      fontSize: media.width * sixteen,
                      color:
                          (widget.textcolor != null) ? widget.textcolor : page,
                      fontWeight: widget.fontweight ?? FontWeight.bold,
                      letterSpacing: 1)
                  : GoogleFonts.poppins(
                      fontSize: media.width * sixteen,
                      color:
                          (widget.textcolor != null) ? widget.textcolor : page,
                      fontWeight: widget.fontweight ?? FontWeight.bold,
                      letterSpacing: 1),
            ),
          ),
        ),
      ),
    );
  }
}

//input field style

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  dynamic icon;
  dynamic onTap;
  final String text;
  final TextEditingController textController;
  dynamic inputType;
  dynamic maxLength;
  dynamic color;

  // ignore: use_key_in_widget_constructors
  InputField(
      {this.icon,
      this.onTap,
      required this.text,
      required this.textController,
      this.inputType,
      this.maxLength,
      this.color});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return TextFormField(
      maxLength: (widget.maxLength == null) ? null : widget.maxLength,
      keyboardType: (widget.inputType == null)
          ? TextInputType.emailAddress
          : widget.inputType,
      controller: widget.textController,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: inputfocusedUnderline,
          width: 1.2,
          style: BorderStyle.solid,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: (widget.color == null) ? inputUnderline : widget.color,
          width: 1.2,
          style: BorderStyle.solid,
        )),
        prefixIcon: (widget.icon != null)
            ? Icon(
                widget.icon,
                size: media.width * 0.064,
                color: textColor,
              )
            : null,
        hintText: widget.text,
        hintStyle: choosenLanguage == 'ar'
            ? GoogleFonts.cairo(
                fontSize: media.width * sixteen,
                color: hintColor,
              )
            : GoogleFonts.poppins(
                fontSize: media.width * sixteen,
                color: hintColor,
              ),
      ),
      onChanged: widget.onTap,
    );
  }
}

class MyText extends StatelessWidget {
  @required
  final String? text;
  // final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? size;
  final FontWeight? fontweight;
  final Color? color;
  const MyText({
    Key? key,
    required this.text,
    // this.style,
    this.maxLines,
    required this.size,
    this.overflow,
    this.textAlign,
    this.fontweight,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null ? '' : text.toString(),
      style: choosenLanguage == 'ar'
          ? GoogleFonts.cairo(
              fontSize: size,
              fontWeight: fontweight ?? FontWeight.normal,
              color: color ?? textColor)
          : GoogleFonts.poppins(
              fontSize: size,
              fontWeight: fontweight ?? FontWeight.normal,
              color: color ?? textColor),

      maxLines: maxLines,

      // textDirection: TextDirection.RTL,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

// ignore: must_be_immutable
class NavMenu extends StatefulWidget {
  dynamic onTap;
  final String text;
  dynamic textcolor;
  final String? image;
  dynamic icon;

  NavMenu({
    Key? key,
    required this.onTap,
    required this.text,
    this.textcolor,
    this.image,
    this.icon,
  }) : super(key: key);

  @override
  State<NavMenu> createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
// F9C27D
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(top: media.width * 0.025),
        child: Column(
          children: [
            Row(
              children: [
                widget.icon == null
                    ? Image.asset(
                        widget.image.toString(),
                        fit: BoxFit.contain,
                        width: media.width * 0.075,
                        color: textColor.withOpacity(0.8),
                      )
                    : Icon(
                        widget.icon,
                        size: media.width * 0.075,
                        color: textColor.withOpacity(0.8),
                      ),
                SizedBox(
                  width: media.width * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: media.width * 0.55,
                      child: Text(
                        widget.text.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: choosenLanguage == 'ar'
                            ? GoogleFonts.cairo(
                                fontSize: media.width * sixteen,
                                color: textColor)
                            : GoogleFonts.poppins(
                                fontSize: media.width * sixteen,
                                color: textColor.withOpacity(0.8)),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: media.width * 0.05,
                      color: textColor.withOpacity(0.8),
                    ),
                  ],
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                top: media.width * 0.01,
                left: media.width * 0.09,
              ),
              child: Container(
                color: textColor.withOpacity(0.1),
                height: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentSuccess extends StatefulWidget {
  dynamic onTap;
  bool? transfer;
  PaymentSuccess({
    Key? key,
    required this.onTap,
    this.transfer,
  }) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(media.width * 0.05),
      height: media.height * 1,
      width: media.width * 1,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: page),
      child: Column(
        children: [
          SizedBox(
            height: media.height * 0.2,
          ),
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/paymentsuccess.png',
                  fit: BoxFit.contain,
                  width: media.width * 0.7,
                ),
                MyText(
                  text: widget.transfer == null
                      ? '${languages[choosenLanguage]['text_amount_of']} $addMoney ${userDetails['currency_symbol']} ${languages[choosenLanguage]['text_tranferred_to']} ${userDetails['mobile']}'
                      : '${languages[choosenLanguage]['text_amount_of']} ${amount.text} ${userDetails['currency_symbol']} ${languages[choosenLanguage]['text_tranferred_to']} ${phonenumber.text}',
                  textAlign: TextAlign.center,
                  size: media.width * eighteen,
                  fontweight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Button(
              onTap: widget.onTap, text: languages[choosenLanguage]['text_ok'])
        ],
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final dynamic onTap;
  final String hinttext;
  final dynamic textController;
  final dynamic inputType;
  final dynamic maxLength;
  final dynamic countertext;
  final dynamic color;
  final dynamic fontsize;
  final dynamic maxline;
  final dynamic minline;
  final dynamic contentpadding;
  final dynamic readonly;
  final dynamic prefixtext;

  const MyTextField(
      {super.key,
      this.onTap,
      this.textController,
      required this.hinttext,
      this.inputType,
      this.maxLength,
      this.countertext,
      this.fontsize,
      this.maxline,
      this.minline,
      this.contentpadding,
      this.readonly,
      this.prefixtext,
      this.color});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return TextField(
        controller: widget.textController,
        readOnly: (widget.readonly == true) ? true : false,
        maxLength: widget.maxLength,
        maxLines: widget.maxline,
        minLines: widget.minline,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          prefixText: widget.prefixtext,
          prefixStyle: (choosenLanguage == 'ar')
              ? GoogleFonts.cairo(
                  fontSize: widget.fontsize ?? media.width * fourteen,
                  fontWeight: FontWeight.normal,
                  color: textColor)
              : GoogleFonts.poppins(
                  fontSize: widget.fontsize ?? media.width * fourteen,
                  fontWeight: FontWeight.normal,
                  color: textColor),
          contentPadding: widget.contentpadding,
          counterText: widget.countertext ?? '',
          border: InputBorder.none,
          hintText: widget.hinttext,
          hintStyle: (isDarkTheme == true)
              ? choosenLanguage == 'ar'
                  ? GoogleFonts.cairo(
                      fontSize: media.width * fourteen,
                      fontWeight: FontWeight.normal,
                      color: textColor.withOpacity(0.3),
                    )
                  : GoogleFonts.poppins(
                      fontSize: media.width * fourteen,
                      fontWeight: FontWeight.normal,
                      color: textColor.withOpacity(0.3),
                    )
              : (choosenLanguage == 'ar')
                  ? GoogleFonts.cairo(
                      fontSize: widget.fontsize ?? media.width * fourteen,
                      fontWeight: FontWeight.normal,
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.4)
                          : hintColor)
                  : GoogleFonts.poppins(
                      fontSize: widget.fontsize ?? media.width * fourteen,
                      fontWeight: FontWeight.normal,
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.4)
                          : hintColor),
        ),
        style: (choosenLanguage == 'ar')
            ? GoogleFonts.cairo(
                fontSize: widget.fontsize ?? media.width * fourteen,
                fontWeight: FontWeight.normal,
                color: (isDarkTheme == true) ? Colors.white : textColor)
            : GoogleFonts.poppins(
                fontSize: widget.fontsize ?? media.width * fourteen,
                fontWeight: FontWeight.normal,
                color: (isDarkTheme == true) ? Colors.white : textColor),
        onChanged: widget.onTap);
  }
}
