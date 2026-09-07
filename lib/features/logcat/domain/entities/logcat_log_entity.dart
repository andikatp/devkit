enum LogLevel { verbose, debug, info, warn, error }

class LogcatLogEntity {
  const new({
    required this.timestamp,
    required this.pid,
    required this.tid,
    required this.level,
    required this.tag,
    required this.message,
  });

  final String timestamp;
  final int pid;
  final int tid;
  final LogLevel level;
  final String tag;
  final String message;

  String get fullText =>
      '$timestamp $pid $tid ${level.name[0].toUpperCase()} $tag: $message';
}
