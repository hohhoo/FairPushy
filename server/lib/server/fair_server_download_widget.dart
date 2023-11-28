import 'dart:ffi';

import 'package:HotUpdateService/server/src/get_server.dart';
import 'package:HotUpdateService/server/fair_server_response.dart';

/*
* 下载处理的基类
* */
abstract class FairDownloadServiceWidget extends GetView {
  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
          future: this.requestHandler(context.request),
          builder: (context, snapshot) {
            if (snapshot?.connectionState == ConnectionState.done) {
              return SuccessDownloadFile(data: snapshot?.data);
            } else {
              return WidgetEmpty();
            }
          });
    } catch (e) {
      return Error(error: e.toString());
    }
  }

  /**
   * 处理不同请求的参数
   */
  Future<String> requestHandler(ContextRequest req) async {
    if (req.requestMethod == Method.get) {
      return (await this.service(req.uri.queryParameters));
    } else if (req.requestMethod == Method.post) {
      return (await this.service(await req.payload()));
    } else {
      return (await this.service(req.uri.queryParameters));
    }
  }

  Future<String> service(Map? request_params);
}
