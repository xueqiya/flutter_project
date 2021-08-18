import 'package:flutter/material.dart';
import 'package:flutter_project/bean/login.dart';
import 'package:flutter_project/common/toast.dart';
import 'package:flutter_project/constants.dart';
import 'package:flutter_project/utils/http_utils.dart';

import '../common/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //key
  final _formKey = GlobalKey<FormState>();

  // 控制器
  final _unameController = TextEditingController();
  final _pwdController = TextEditingController();

  //焦点
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    _children.add(_mainView());
    if (showLoading) {
      _children.add(Loading());
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: Stack(children: _children));
  }

  Widget _mainView() {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 70.0),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Image.asset(
              'assets/images/ic_launcher.png',
              width: 80,
              height: 80,
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFormField(
                  controller: _unameController,
                  focusNode: _focusNode1,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '请输入账号',
                    labelText: "账号",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
                  ),
                  validator: (v) {
                    return v.length != 11 ? '请输入11位账号' : null;
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode2),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _pwdController,
                  focusNode: _focusNode2,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 20,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    labelText: '密码',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
                  ),
                  validator: (v) {
                    return v.length < 6 || v.length > 20 ? '密码由6到20位密码' : null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: MaterialButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
              child: Text('登录', style: TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: () => _login(),
            ),
          ),
          TextButton(
            child: Text('忘记密码?', style: TextStyle(color: Colors.black54, fontSize: 15.0)),
            onPressed: () {
              Navigator.pushNamed(context, 'forget');
            },
          ),
        ],
      ),
    );
  }

  void _login() {
    var _state = _formKey.currentState;
    if (!_state.validate()) return;
    _state.save();
    FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
    _loginRequest().then((v) {
      if (v.code == 200) {
        showToast('登录成功' + v.data.nikeName, context);
        Navigator.pop(context);
        Navigator.pushNamed(context, 'main');
      } else {
        showToast(v.msg, context);
      }
    });
  }

  Future<Login> _loginRequest() async {
    setState(() {
      showLoading = true;
    });
    try {
      var data = {"phone": _unameController.text, "password": _pwdController.text};
      final response = await HttpUtils.post(URL_LOGIN, data: data);
      if (response.statusCode == 200) {
        return Login.fromJson(response.data);
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      showToast('登录失败' + e.toString(), context);
      throw ("登录失败:" + e.toString());
    } finally {
      setState(() {
        showLoading = false;
      });
    }
  }
}
