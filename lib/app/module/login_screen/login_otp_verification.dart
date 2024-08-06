import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:national_wild_animal/app/module/login_screen/provider/otp_dialog_provider.dart';
import 'package:provider/provider.dart';

import '../../api_service/api_end_point.dart';
import '../../api_service/http_methods.dart';
import '../../common_widgets/opt_text_field.dart';
import '../../common_widgets/show_snack_bar.dart';

class LoginOtpVerification extends StatefulWidget {
  final String? userId;

  LoginOtpVerification({super.key, this.userId});

  @override
  State<LoginOtpVerification> createState() => _LoginOtpVerificationState();

  static Widget builder(BuildContext context, String userId) {
    return ChangeNotifierProvider(
      create: (context) => OtpDialogProvider(),
      child: LoginOtpVerification(
        userId: userId,
      ),
    );
  }
}

class _LoginOtpVerificationState extends State<LoginOtpVerification> {
  TextEditingController num1 = TextEditingController();

  TextEditingController num2 = TextEditingController();

  TextEditingController num3 = TextEditingController();

  TextEditingController num4 = TextEditingController();

  callOtpVerify() {
    String token =
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzeXN0ZW0iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUk9MRV9TVVBFUl9BRE1JTiJ9LHsiYXV0aG9yaXR5IjoiVklFVyJ9LHsiYXV0aG9yaXR5IjoiRURJVCJ9LHsiYXV0aG9yaXR5IjoiQ1JFQVRFIn0seyJhdXRob3JpdHkiOiJERUxFVEUifV0sInJlZnJlc2giOmZhbHNlLCJleHAiOjE3MjIzNTAzMjUsImlhdCI6MTcyMjMxNDMyNX0.MjlNY93P_OP4X5nZAgEkI_rmPJoDjNShpGDjooXBIgc";

    HttpMethodsDio().getMethodWithToken(api: ApiEndPoint.signUpUrl(widget.userId??""),
        fun: (map, code) {
           if(code == 200){

           }
        }, token: token);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 40, bottom: 40, left: 0, right: 0),
          height: size.height * 0.6,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Dialog(
                  backgroundColor: const Color(0xFF231D32),
                  insetPadding: EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/logo1.png"),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Enter OTP",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OptTextField(
                                  controller: num1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OptTextField(
                                  controller: num2,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OptTextField(
                                  controller: num3,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OptTextField(
                                  controller: num4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<OtpDialogProvider>(
                              builder: (context, provider, child) {
                                return Text(
                                  context.read<OtpDialogProvider>().invalidOtp ? 'Invalid OTP' : '',
                                  style: TextStyle(fontSize: 15, color: Colors.red),
                                );
                              },
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF760ABE), Color(0xFFB74BFF)], // Define your gradient colors here
                                ),
                                //borderRadius: BorderRadius.circular(radius),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  // await Future.delayed(const Duration(seconds: 2));

                                  final otp = num1.text + num2.text + num3.text + num4.text;

                                  if (otp != '1234') {
                                    context.read<OtpDialogProvider>().changeStatus(status: true);
                                    // ShowSnackBar.showError(context, "Invalid otp.....");
                                    // Navigator.pop(context);
                                  } else if (otp == '1234') {
                                    context.read<OtpDialogProvider>().changeStatus(status: false);
                                    Navigator.pushNamed(context, "/bottomAppBarProvider");
                                  } else {
                                    context.read<OtpDialogProvider>().changeStatus(status: true);
                                  }
                                },
                                child: const Text(
                                  "Verify",
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                    maximumSize: Size.fromHeight(50)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  top: 18,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      margin: EdgeInsets.all(0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ))
              //this is the second component for circular progress indicator...........
            ],
          )),
    );
  }
}