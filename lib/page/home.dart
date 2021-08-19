import 'package:flutter/material.dart';
import 'package:flutter_project/bean/goods.dart';
import 'package:flutter_project/common/toast.dart';
import 'package:flutter_project/constants.dart';
import 'package:flutter_project/utils/http_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> _list = [];
  int _pageNum = 1;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _onRefresh();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _pageNum++;
        _getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _list.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return _itemView(index);
      },
    );
  }

  Widget _itemView(int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('${_list[index].nikeName}'), Text('${_list[index].price}元')],
              ),
              Row(
                children: [Text('【${_list[index].keyword}】'), Text('${_list[index].content}')],
              ),
              SizedBox(height: 100.0)
            ],
          ),
        ),
        Divider(height: 8)
      ],
    );
  }

  Future<void> _onRefresh() async {
    _pageNum = 1;
    _getData();
    await Future.delayed(Duration(milliseconds: 1500));
    return Future.value(true);
  }

  void _getData() {
    _dataRequest().then((value) {
      setState(() {
        if (value.data.length < 10) {
          showToast("没有更多了", context);
        }
        _list.addAll(value.data);
      });
    });
  }

  Future<Goods> _dataRequest() async {
    if (_pageNum == 1) {
      _list.clear();
    }
    try {
      final response = await HttpUtils.get(URL_GOODS + "?page=" + _pageNum.toString());
      if (response.statusCode == 200) {
        return Goods.fromJson(response.data);
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      showToast('获取失败' + e.toString(), context);
      throw ("home获取失败:" + e.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
