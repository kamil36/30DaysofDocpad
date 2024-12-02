import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay extends StatefulWidget {
  const RazorPay({Key? key}) : super(key: key);

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  late Razorpay _razorpay; // Razorpay instance
  bool _isLoading = false; // To track if payment is in process

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    // Listen to Razorpay payment events
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // Payment Success handling
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isLoading = false; // Stop the loading state
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Successful: ${response.paymentId}"),
    ));
    // Perform further actions on successful payment (like sending payment data to the server)
  }

  // Payment Failure handling
  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false; // Stop the loading state
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Failed: ${response.code} - ${response.message}"),
    ));
    // Handle failure event (like retry logic or alerting user)
  }

  // External wallet payment handling (e.g., Paytm, PhonePe)
  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isLoading = false; // Stop the loading state
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("External Wallet: ${response.walletName}"),
    ));
    // Handle external wallet payment logic here
  }

  // Start the payment process
  void _startPayment() {
    var options = {
      'key': 'rzp_test_8q6i0nQ3mc239Y',  // Use your Razorpay API key here
      'amount': 200 * 100,  // Amount in paise (100 paise = 1 INR)
      'name': 'Flipkart',
      'description': 'Test Payment',
      'timeout': 60,
      'prefill': {
        'contact': '1234567890',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm'],  // Wallet options (optional)
      }
    };

    setState(() {
      _isLoading = true;  // Show loading indicator
    });

    try {
      _razorpay.open(options);  // Open the Razorpay payment gateway
    } catch (e) {
      setState(() {
        _isLoading = false;  // Stop loading if there's an error
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // Dispose the Razorpay instance when widget is destroyed
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razorpay Payment Gateway"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator() // Show loading spinner during payment
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 70),
                  backgroundColor: Colors.grey[800],
                ),
                onPressed: _startPayment,  // Start payment when clicked
                child: Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Click the button to start Razorpay payment",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
