import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';

import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/presentation/widget/custom_text_form.dart';
import 'package:shoes_app/utils/styles.dart';

class SignInPage extends StatelessWidget {
  static const routeName = "/sign-in";
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icon_logo2.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Login to Your Account",
                  style: Theme.of(context).textTheme.headline5?.copyWith(color: kBlackColor, fontSize: 26),
                ),
                const SizedBox(height: 20),
                _inputSection(context),
                const SizedBox(height: 40),
                footer(context)


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputSection(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextForm(
              title: "Email Address",
              hintText: "Your Email Address",
              errorText: "Please Input Your Email",
              textEditingController: emailController,
              prefixIcons: const Icon(Icons.email),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextForm(
              title: "Password",
              hintText: "Your Password",
              errorText: "Please Input Your Password",
              textEditingController: passwordController,
              prefixIcons: const Icon(Icons.lock),
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            _signButton(context)
          ],
        ),
      ),
    );
  }

  Widget _signButton(BuildContext context){
    return CustomButton(
      title: "Sign in",
      margin: const EdgeInsets.symmetric(horizontal: 16),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacementNamed(context, MainPage.routeName);
        }
      },
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dont\'t have an account ? ',
            style: Theme.of(context).textTheme.bodyText2
          ),
          GestureDetector(
            child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: kGreenColor)
            ),
            onTap: () {
              Navigator.pushNamed(context, '/sign-up');
            },
          )
        ],
      ),
    );
  }
}
