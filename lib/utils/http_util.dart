import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as GET;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:bcccoin/utils/constent.dart';
import 'package:bcccoin/utils/setting.dart';

import '../main.dart';

class HttpUtil {
  static HttpUtil? instance;
  Dio? dio;
  BaseOptions? options;
  bool isTest = true;
  CancelToken cancelToken = CancelToken();

  static HttpUtil? getInstance() {
    instance ??= HttpUtil();
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil() {
    String? token = Setting.storage.read("token");
    print('TOKEN ========> $token');
    options = BaseOptions(
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 60),
      followRedirects: false,
      headers: {"Authorization": "Bearer $token"},
      responseType: ResponseType.json,
    );

    print("hellloooooooooooooooooooooooooooooooooooooooooo1111222221222");
    dio = Dio(options);

    print("hellloooooooooooooooooooooooooooooooooooooooooo");
  }

  /*
   * get请求
   */
  Future<Response?> get(BuildContext? ctx, url,
      {data,
      options,
      cancelToken,
      bool? conserveUrl,
      bool showLog = true,
      bool isSnack = true}) async {
    var endpoint = conserveUrl ?? false
        ? url
        : (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('URL==========> $endpoint $data');
    Response? response;
    try {
      response = await dio!.get(endpoint,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      if (showLog) {
        print('get success---------${response.data}');
      }

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码
    } on DioException catch (e) {
      print('DioError URL==========> $endpoint $data');
      print('get error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
    // return response;
  }

  /*
   * delete请求
   */
  Future<Response?> delete(BuildContext? ctx, url,
      {data,
      options,
      cancelToken,
      bool? conserveUrl,
      bool showLog = true,
      bool isSnack = true}) async {
    var endpoint = conserveUrl ?? false
        ? url
        : (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('URL==========> $endpoint $data');
    Response? response;
    try {
      response = await dio!.delete(endpoint,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      if (showLog) {
        print('get success---------${response.data}');
      }

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码
    } on DioException catch (e) {
      print('DioError URL==========> $endpoint $data');
      print('get error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
    // return response;
  }

//postFiles

  Future<Response?> postFiles(BuildContext? ctx, url, File file,
      {data, options, bool isSnack = true}) async {
    var endpoint = (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('posFiles URL==========> $endpoint');

    Response? response;
    try {
      // Crée un objet FormData avec un seul fichier
      FormData formData = FormData.fromMap({
        "document": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
        "commentaire": "commentaire"
      });

      response = await dio!.post(endpoint,
          data: formData, options: options, cancelToken: cancelToken);
      print('postFiles post success---------${response.data}');
      print(response.data.runtimeType);
    } on DioError catch (e) {
      // Gérer l'erreur ici si nécessaire
      // print('post error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
  }
  //postFiles

  /*
   * post请求
   */
  Future<Response?> post(BuildContext? ctx, url,
      {data,
      options,
      cancelToken,
      bool? conserveUrl /* permet d'utilsier l'url donné à son intégralité */,
      bool isSnack = true}) async {
    var endpoint = conserveUrl ?? false
        ? url
        : (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('URL==========> $endpoint $data');
    Response? response;
    try {
      response = await dio!.post(endpoint,
          data: data,
          options: options,
          cancelToken: cancelToken, onSendProgress: (int sent, int total) {
        final progress = sent / total;
      });
      print('post success---------${response.data}');
      // print(response.data.runtimeType);
    } on DioError catch (e) {
      print('DioError URL==========> $endpoint et $e');
      // print('post error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
  }

  /*
   * post请求
   */
  put(BuildContext? ctx, url,
      {data, options, cancelToken, bool isSnack = true}) async {
    var endpoint = (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('URL==========> $endpoint');
    Response? response;
    try {
      response = await dio!.put(endpoint,
          data: json.encode(data), options: options, cancelToken: cancelToken);
      print('post success---------${response.data}');
      print(response.data.runtimeType);
    } on DioError catch (e) {
      // print('post error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
  }

  multiFileProcess(List<File> images) async {
    List<MultipartFile> multipartImageList = <MultipartFile>[];

    for (var i = 0; i < images.length; i++) {
      File asset = images[i];
      var name = basename(asset.path);
      List n1 = name.split('.');
      String type = n1[n1.length - 1];
      MultipartFile multipartFile = await MultipartFile.fromFile(
        asset.path,
        filename: name,
        contentType: MediaType("image", type),
      );
      multipartImageList.add(multipartFile);
    }
    return multipartImageList;
  }

  Future<Response?> postWithMedia(BuildContext? ctx, url, List<File> images,
      {data, options, bool isSnack = true}) async {
    var endpoint = (isTest ? Const.TEST_URL : Const.BASE_URL) + url;
    print('postWithMedia URL==========> $endpoint');
    var files = await multiFileProcess(images);
    Response? response;
    try {
      FormData formData =
          new FormData.fromMap({"file": files, "data": json.encode(data)});

      response = await dio!.post(endpoint,
          data: formData, options: options, cancelToken: cancelToken);
      print('postWithMedia post success---------${response.data}');
      print(response.data.runtimeType);
    } on DioError catch (e) {
      // print('post error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(BuildContext ctx, urlPath, savePath,
      {bool isSnack = true}) async {
    Response? response;
    // app.downloadCancelToken.value = cancelToken;
    try {
      response = await dio!.download(urlPath, savePath,
          cancelToken: cancelToken, onReceiveProgress: (int count, int total) {
        //进度
        final progress = count / total;

        print("$count $total $progress");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      // formatError(e, ctx, isSnack: isSnack);
    }
    return response;
  }

  /*
  UPLOAD
   */

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
