import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/retry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ClientKeeper {

  ClientKeeper._internal();

  static final ClientKeeper _CK = ClientKeeper._internal();
  static ClientKeeper get instance => _CK;
  static Dio? _client;
  static Dio? _JSONClient;
  static PersistCookieJar? _cookies;

  Future<PersistCookieJar> grabCookieJar() async {
    if (_cookies != null) return _cookies!;

    final String appDocPath = (await getApplicationDocumentsDirectory()).path;
    _cookies = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage("$appDocPath/.cookies/")
    );

    return _cookies!;
  }

  Future<Dio> get client async {
    if (_client != null) return _client!;

    _client = Dio();
    _client!.interceptors.add(CookieManager(await grabCookieJar()));
    _client!.interceptors.add(TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: false,
        // printResponseHeaders: true,
        printResponseMessage: true,
        printResponseData: false,
      ),
    ));

    return _client!;
  }

  Future<Dio> get JSONClient async {
    if (_JSONClient != null) return _JSONClient!;

    _JSONClient = Dio(BaseOptions(headers: {'Accept': 'application/json'}));
    _JSONClient!.interceptors.add(CookieManager(await grabCookieJar()));
    _JSONClient!.interceptors.add(TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: false,
        // printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ));

    return _JSONClient!;
  }

  Future<void> closeClient() async {
    if (_client != null) (_client as RetryClient).close();
  }

  Future<void> closeJSONClient() async {
    if (_JSONClient != null) (_JSONClient as RetryClient).close();
  }
}