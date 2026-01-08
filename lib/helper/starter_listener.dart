// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/legacy.dart';

// // Adapter to convert StateNotifier to Listenable
// class StateNotifierListenable<T> extends Listenable {
//   final StateNotifier<T> notifier;
//   VoidCallback? _listener;

//   StateNotifierListenable(this.notifier);

//   @override
//   void addListener(VoidCallback listener) {
//     _listener = listener;
//     notifier.addListener((state) {
//       listener();
//     });
//   }

//   @override
//   void removeListener(VoidCallback listener) {
//     _listener = null;
//   }
// }
