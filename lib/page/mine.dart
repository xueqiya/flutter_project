import 'package:flutter/material.dart';
import 'package:flutter_project/bean/user.dart';
import 'package:flutter_project/common/toast.dart';
import 'package:flutter_project/constants.dart';
import 'package:flutter_project/utils/http_utils.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  User _data;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(_data == null ? " " : "姓名：" + _data.data.nikeName),
            Text(_data == null ? " " : "手机号:" + _data.data.phone),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _getData();
    await Future.delayed(Duration(milliseconds: 1500));
    return Future.value(true);
  }

  void _getData() {
    _dataRequest().then((value) {
      setState(() {
        _data = value;
      });
    });
  }

  Future<User> _dataRequest() async {
    try {
      final response = await HttpUtils.get(URL_USER + "/1");
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      showToast('获取失败' + e.toString(), context);
      throw ("user获取失败:" + e.toString());
    }
  }
}
