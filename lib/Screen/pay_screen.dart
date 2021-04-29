import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/google_pay_constants.dart'
    as google_pay_constants;
import 'package:yalla_activities/Screen/pay_widget/buy_sheet.dart';

import '../constant.dart';
class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  bool isLoading = true;
  bool applePayEnabled = false;
  bool googlePayEnabled = false;
@override
void     initState() 
{
      _initSquarePayment();

}
   Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(squareApplicationId);

    var canUseApplePay = false;
    var canUseGooglePay = false;
    if (Platform.isAndroid) {
      await InAppPayments.initializeGooglePay(
          squareLocationId, google_pay_constants.environmentTest);
      canUseGooglePay = await InAppPayments.canUseGooglePay;
     } 
    //else if (Platform.isIOS) {
    //   await _setIOSCardEntryTheme();
    //   await InAppPayments.initializeApplePay(applePayMerchantId);
    //   canUseApplePay = await InAppPayments.canUseApplePay;
    // }
    setState(() {
      isLoading = false;
      applePayEnabled = canUseApplePay;
      googlePayEnabled = canUseGooglePay;
    });
   }
   Future _setIOSCardEntryTheme() async {
    var themeConfiguationBuilder = IOSThemeBuilder();
    themeConfiguationBuilder.saveButtonTitle = 'Pay';
    themeConfiguationBuilder.errorColor = RGBAColorBuilder()
      ..r = 255
      ..g = 0
      ..b = 0;
    themeConfiguationBuilder.tintColor = RGBAColorBuilder()
      ..r = 36
      ..g = 152
      ..b = 141;
    themeConfiguationBuilder.keyboardAppearance = KeyboardAppearance.light;
    themeConfiguationBuilder.messageColor = RGBAColorBuilder()
      ..r = 114
      ..g = 114
      ..b = 114;

    await InAppPayments.setIOSCardEntryTheme(themeConfiguationBuilder.build());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:

      
                                        isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(mainBackgroundColor),
                ))
              : BuySheet(
                  applePayEnabled: applePayEnabled,
                  googlePayEnabled: googlePayEnabled,
                  applePayMerchantId: applePayMerchantId,
                  squareLocationId: squareLocationId),
      
    );
  }
}