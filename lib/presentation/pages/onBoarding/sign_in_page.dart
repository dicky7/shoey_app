import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/providers/preferences_provider.dart';

import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/presentation/widget/custom_text_form.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../../utils/app_utils.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showCustomDialog(
            context: context,
            title: "Hurray :)",
            content: "Sign In Success, Welcome to Shoey",
            buttonTitle: "Lets go",
            icons: Icons.check,
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false),
          );

        }else if(state is AuthError){
          showCustomDialogError(
            context: context,
            title: "Error",
            content: state.message,
            icons: Icons.close,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomButton(
          title: "Sign in",
          margin: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signIn(
                  email: emailController.text,
                  password: passwordController.text
              );
            }
          },
        );
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
