import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'colors.dart';
import 'constant.dart';

// Elevated button .....................................>>>
// ignore: must_be_immutable
class elevatedButton extends StatefulWidget {
  VoidCallback? onPress;
  var isStroked = false;
  double? elevation;
  Widget? widget;
  ValueChanged? onFocusChanged;
  Color backgroundColor;
  Color bodersideColor;
  var height;
  var width;
  var borderRadius;
  var looding;

  elevatedButton(
    BuildContext context, {
    Key? key,
    this.looding = false,
    var this.isStroked = false,
    this.onFocusChanged,
    required var this.onPress,
    this.elevation,
    var this.widget,
    var this.backgroundColor = colorPrimary,
    var this.bodersideColor = colorPrimary,
    var this.borderRadius = 10.0,
    var this.height = 55.0,
    var this.width = double.infinity,
  }) : super(key: key);

  @override
  State<elevatedButton> createState() => _elevatedButtonState();
}

class _elevatedButtonState extends State<elevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
          onFocusChange: widget.onFocusChanged,
          onPressed: widget.onPress,
          style: widget.isStroked
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder())
              : ElevatedButton.styleFrom(
                  elevation: widget.elevation,
                  side: BorderSide(color: widget.bodersideColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius)),
                  backgroundColor: widget.backgroundColor,
                ),
          child: widget.looding
              ? const CircularProgressIndicator(
                  color: color_white,
                  strokeWidth: 2,
                )
              : widget.widget),
    );
  }
}
// Elevated button .....................................>>>Finished

// Text widget .....................................>>>Start
Widget text(String? text,
    {var fontSize = textSizeMedium,
    Color? textColor,
    var fontFamily = 'Poppins',
    var isCentered = false,
    var maxLine = 1,
    TextOverflow? overflow,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
    var fontWeight = FontWeight.w400}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: overflow,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor ?? textColorPrimary,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

class utils {
  void toastMethod(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

// Only for spacific Project Build Classes...........................
// ignore: must_be_immutable
class buildRow extends StatelessWidget {
  String? title;
  String? type;
  buildRow({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: text(
              title.toString(),
              fontWeight: FontWeight.w500,
              textColor: colorPrimary,
              fontSize: textSizeSMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: text(
              type.toString(),
              fontSize: textSizeSMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Text TextFrom Feild FilledColor...........................................>>>
// ignore: must_be_immutable
class textformfield extends StatelessWidget {
  VoidCallback? onPressed;
  FormFieldValidator<String>? validator;
  FormFieldValidator<String>? onSaved;
  ValueChanged? onChanged;
  TextEditingController? controller;
  ValueChanged<String>? onFieldSubmitted;
  var hight;
  var hinttext;
  var filledColor;
  var suffixIcons;
  var prefixIcons;
  var borderSide;
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var suffixWidth;
  var maxLine;
  var obscureText = false;
  TextInputType? keyboardType;
  textformfield({
    Key? key,
    this.onFieldSubmitted,
    this.controller,
    required this.obscureText,
    this.validator,
    this.onSaved,
    this.onChanged,
    var this.hight = 50.0,
    this.onPressed,
    var this.suffixWidth = 50.0,
    var this.hinttext,
    var this.filledColor,
    var this.prefixIcons,
    var this.suffixIcons,
    var this.borderSide,
    var this.fontFamily,
    var this.fontSize = textSizeMedium,
    var this.isPassword = false,
    var this.isSecure = false,
    var this.keyboardType,
    var this.maxLine = 1,
    var this.text,
    var this.textColor = textColorSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: hight,
        child: TextFormField(
          maxLines: maxLine,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          obscureText: obscureText,
          onTap: onPressed,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: prefixIcons,
              suffixIcon: suffixIcons,
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 50, maxWidth: suffixWidth),
              filled: true,
              fillColor: filedColor,
              border: OutlineInputBorder(
                  borderSide: borderSide ?? BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 13.0)),
        ));
  }
}

// Text TextFrom .....................................>>>

