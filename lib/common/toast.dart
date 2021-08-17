import 'package:toast/toast.dart';

showToast(String msg, context) {
  Toast.show(
      msg, //必填
      context, //必填
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.CENTER,
      backgroundRadius: 4);
}