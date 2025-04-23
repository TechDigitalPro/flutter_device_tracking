part of 'flutter_bluetooth_serial.dart';

/// Represents ongoing Bluetooth connection to remote device.
class BluetoothConnection {
  // Note by PsychoX at 2019-08-19 while working on issue #60:
  // Fixed and then tested whole thing multiple times:
  // - [X] basic `connect`, use `output`/`input` and `disconnect` by local scenario,
  // - [X] fail on connecting to device that isn't listening,
  // - [X] working `output` if no `listen`ing to `input`,
  // - [X] closing by local if no `input` written,
  // - [X] closing by local if no `listen`ing to `input` (this was the #60),
  // - [X] closing by remote if no `input` written,
  // - [X] closing by remote if no `listen`ing to `input`,
  //    It works, but library user is notifed either by error on `output.add` or
  //    by observing `connection.isConnected`. In "normal" conditions user can
  //    listen to `input` even just for the `onDone` to proper detect closing.
  //


  final EventChannel _readChannel;
  late StreamSubscription<Uint8List> _readStreamSubscription;
  late StreamController<Uint8List> _readStreamController;

  /// Stream sink used to read from the remote Bluetooth device
  ///
  /// `.onDone` could be used to detect when remote device closes the connection.
  ///
  /// You should use some encoding to receive string in your `.listen` callback, for example `ascii.decode(data)` or `utf8.encode(data)`.
  Stream<Uint8List>? input;

  /// Stream sink used to write to the remote Bluetooth device
  ///
  /// You should use some encoding to send string, for example `.add(ascii.encode('Hello!'))` or `.add(utf8.encode('Cześć!))`.
  late _BluetoothStreamSink output;

  /// Describes is stream connected.
  bool get isConnected => output.isConnected;

  BluetoothConnection._consumeConnectionID(int? id)
      : _readChannel =
            EventChannel('${FlutterBluetoothSerial.namespace}/read/$id') {
    _readStreamController = StreamController<Uint8List>();

    _readStreamSubscription =
        _readChannel.receiveBroadcastStream().cast<Uint8List>().listen(
              _readStreamController.add,
              onError: _readStreamController.addError,
              onDone: this.close,
            );

    input = _readStreamController.stream;
    output = _BluetoothStreamSink(id);
  }

  /// Returns connection to given address.
  static Future<BluetoothConnection> toAddress(String? address) async {
    // Sorry for pseudo-factory, but `factory` keyword disallows `Future`.
    return BluetoothConnection._consumeConnectionID(await FlutterBluetoothSerial
        ._methodChannel
        .invokeMethod('connect', {"address": address}));
  }

  /// Should be called to make sure the connection is closed and resources are freed (sockets/channels).
  void dispose() {
    finish();
  }

  /// Closes connection (rather immediately), in result should also disconnect.
  Future<void> close() {
    return Future.wait([
      output.close(),
      _readStreamSubscription.cancel(),
      (!_readStreamController.isClosed)
          ? _readStreamController.close()
          : Future.value(/* Empty future */)
    ], eagerError: true);
  }

  /// Closes connection (rather immediately), in result should also disconnect.
  @Deprecated('Use `close` instead')
  Future<void> cancel() => this.close();

  /// Closes connection (rather gracefully), in result should also disconnect.
  Future<void> finish() async {
    await output.allSent;
    close();
  }
}

/// Helper class for sending responses.
class _BluetoothStreamSink implements StreamSink<Uint8List> {
  final int? _id;
  bool isConnected = true;
  Future<void> _chainedFutures = Future.value();
  late Future<dynamic> _doneFuture;
  dynamic exception;

  _BluetoothStreamSink(this._id) {
    _doneFuture = Future(() async {
      while (this.isConnected) {
        await Future.delayed(Duration(milliseconds: 111));
      }
      if (this.exception != null) {
        throw this.exception;
      }
    });
  }

  @override
  void add(Uint8List data) {
    if (!isConnected) throw StateError("Not connected!");
    _chainedFutures = _chainedFutures.then((_) async {
      if (!isConnected) throw StateError("Not connected!");
      await FlutterBluetoothSerial._methodChannel
          .invokeMethod('write', {'id': _id, 'bytes': data});
    }).catchError((e) {
      this.exception = e;
      close();
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    throw UnsupportedError("BluetoothConnection output cannot receive errors!");
  }

  @override
  Future addStream(Stream<Uint8List> stream) async {
    var completer = Completer();
    stream.listen(this.add).onDone(completer.complete);
    await completer.future;
    await _chainedFutures;
  }

  @override
  Future close() {
    isConnected = false;
    return done;
  }

  @override
  Future get done => _doneFuture;

  Future get allSent async {
    Future lastFuture;
    do {
      lastFuture = this._chainedFutures;
      await lastFuture;
    } while (lastFuture != this._chainedFutures);

    if (this.exception != null) {
      throw this.exception;
    }

    this._chainedFutures = Future.value();
  }
}