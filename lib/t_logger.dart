library t_logger;

import 'dart:developer' as _dev;

///日志等级
///* [DEBUG] 调试
///* [INFO] 信息
///* [WARNING] 警告
///* [ERROR] 错误
enum LOGLEVEL { DEBUG, INFO, WARNING, ERROR }

///日志等级枚举扩展
extension LogLevelExtension on LOGLEVEL {
  ///获取tag
  String get tag {
    switch (this) {
      case LOGLEVEL.DEBUG:
        return '[DEBUG]   ';
      case LOGLEVEL.INFO:
        return '[INFO]    ';
      case LOGLEVEL.WARNING:
        return '[WARNING] ';
      case LOGLEVEL.ERROR:
        return '[ERROR]   ';
    }
  }

  ///获取颜色代码
  int get code {
    switch (this) {
      case LOGLEVEL.DEBUG:
        return 5;
      case LOGLEVEL.INFO:
        return 2;
      case LOGLEVEL.WARNING:
        return 3;
      case LOGLEVEL.ERROR:
        return 1;
    }
  }
}

// ignore: avoid_classes_with_only_static_members
///日志输出封装
class TLogger {
  ///顶部图案
  static String get _pic {
    return '''

         ┌─┐       ┌─┐
      ┌──┘ ┴───────┘ ┴──┐
      │                 │
      │       ───       │
      │  ─┬┘       └┬─  │
      │                 │
      │       ─┴─       │
      │                 │
      └───┐         ┌───┘
          │         │ 神兽保佑
          │         │ 永无BUG
          │         │
          │         └──────────────┐
          │                        │
          │                        ├─┐
          │                        ┌─┘
          │                        │
          └─┐  ┐  ┌───────┬──┐  ┌──┘
            │ ─┤ ─┤       │ ─┤ ─┤
            └──┴──┘       └──┴──┘
  ''';
  }

  ///开发者标识
  static String _tag = 'DEFAULT';

  ///初始化函数
  static void init({String? tag}) {
    _tag = tag ?? _tag;
    tInfo(_pic, showPath: false);
  }

  ///日志着色
  static String _logColor(String info, {int color = 7}) {
    return '\x1B[9${color}m$info\x1B[0m';
  }

  ///日志路径
  static String get _logPath {
    // _dev.log(StackTrace.current.toString());
    final String p = 'package' + StackTrace.current.toString().split('\n')[4].split('package')[1];
    return StackTrace.fromString('\t$p').toString().replaceAll(')', '');
  }

  ///打印信息
  static void _log(dynamic content, {LOGLEVEL lv = LOGLEVEL.INFO, bool showPath = true}) {
    assert(() {
      final String _time = DateTime.now().toString().split('.')[0];

      _dev.log(
        _logColor('[$_tag] ', color: 6) +
            _logColor(lv.tag, color: lv.code) +
            _logColor(content?.toString() ?? '', color: lv == LOGLEVEL.ERROR ? lv.code : 7) +
            '''
                ${showPath ? _logPath : ''}
            ''',
        name: _time,
      );

      return true;
    }());
  }
}

///debug级别日志
void tDebug(dynamic msg, {bool showPath = true}) => TLogger._log(msg, lv: LOGLEVEL.DEBUG, showPath: showPath);

///info级别日志
void tInfo(dynamic msg, {bool showPath = true}) => TLogger._log(msg, lv: LOGLEVEL.INFO, showPath: showPath);

///warning级别日志
void tWarning(dynamic msg, {bool showPath = true}) => TLogger._log(msg, lv: LOGLEVEL.WARNING, showPath: showPath);

///error级别日志
void tError(dynamic msg, {bool showPath = true}) => TLogger._log(msg, lv: LOGLEVEL.ERROR, showPath: showPath);
