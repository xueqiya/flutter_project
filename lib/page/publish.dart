import 'package:flutter/material.dart';
import 'package:flutter_project/bean/common.dart';
import 'package:flutter_project/common/toast.dart';
import 'package:flutter_project/constants.dart';
import 'package:flutter_project/utils/http_utils.dart';

import '../common/loading.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  //key
  final _formKey = GlobalKey<FormState>();

  // 控制器
  final _priceController = TextEditingController();
  final _keywordController = TextEditingController();
  final _contentController = TextEditingController();

  //焦点
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

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
          title: Text("找人干活"),
        ),
        body: Stack(children: _children));
  }

  Widget _mainView() {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 70.0),
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFormField(
                  controller: _keywordController,
                  focusNode: _focusNode1,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '请输入关键字',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
                  ),
                  validator: (v) {
                    return v.length > 10 ? '' : null;
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode2),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  focusNode: _focusNode2,
                  keyboardType: TextInputType.text,
                  maxLength: 200,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '请输入详情',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
                  ),
                  validator: (v) {
                    return v.length > 200 ? '' : null;
                  },
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode3),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  focusNode: _focusNode3,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: '请输入价格',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
                  ),
                  validator: (v) {
                    return v.length > 20 ? '' : null;
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
              child: Text('找人干活', style: TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: () => _publish(),
            ),
          ),
        ],
      ),
    );
  }

  void _publish() {
    var _state = _formKey.currentState;
    if (!_state.validate()) return;
    _state.save();
    FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
    _publishRequest().then((v) {
      if (v.code == 200) {
        showToast('发布成功', context);
        Navigator.pop(context);
      } else {
        showToast(v.msg, context);
      }
    });
  }

  Future<Common> _publishRequest() async {
    setState(() {
      showLoading = true;
    });
    try {
      var data = {
        "user_id": 1,
        "price": int.parse(_priceController.text),
        "keyword": _keywordController.text,
        "content": _contentController.text,
        "location": "12.65|52.51",
        "address": "北京市海淀区"
      };
      final response = await HttpUtils.post(URL_GOODS, data: data);
      if (response.statusCode == 200) {
        return Common.fromJson(response.data);
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      showToast('发布失败' + e.toString(), context);
      throw ("发布失败:" + e.toString());
    } finally {
      setState(() {
        showLoading = false;
      });
    }
  }
}
