import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:job_board/controllers/profile/profile_provider.dart';
import 'package:job_board/services/config.dart';

final aiPaymentProvider =
    StateNotifierProvider<AiPaymentNotifier, AsyncValue<void>>(
      (ref) => AiPaymentNotifier(ref),
    );

class AiPaymentNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  AiPaymentNotifier(this.ref) : super(const AsyncData(null));

  Future<void> payForAi(String token) async {
    state = const AsyncLoading();

    try {
      final client = http.Client();

      final url = Uri.http(Config.apiUrl, Config.paymentIntent);
      final res = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final decoded = json.decode(res.body);
      final clientSecret = decoded['clientSecret'];
      final orderId = decoded['orderId'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Job Board AI',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      final confirmUrl = Uri.http(Config.apiUrl, Config.paymentConfirm);
      await client.post(
        confirmUrl,
        body: json.encode({'orderId': orderId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      
      await ref.read(profileProvider.notifier).fetchProfile();

      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
