import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  OverlayEntry? _overlayEntry;

  void showLoading(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          left: MediaQuery.of(context).size.width * 0.45,
          child: CircularProgressIndicator(),
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
      setLoading(true);
    });
  }

  void hideLoading() {
    Future.delayed(Duration.zero, () {
      if (_overlayEntry != null) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
      setLoading(false);
    });
  }
}
