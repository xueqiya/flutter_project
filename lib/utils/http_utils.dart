import 'package:dio/dio.dart';

class HttpUtils {
  static Future get(
    String url, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    String cacheKey,
    bool cacheDisk = false,
  }) async {
    return await Dio().get(url);
  }

  static Future post(
    String url, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Dio().post(url, data: data);
  }

  static Future put(
    String url, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Dio().put(url, data: data);
  }

  static Future patch(
    String url, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Dio().put(url, data: data);
  }

  static Future delete(
    String url, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    return await Dio().put(url, data: data);
  }
}
