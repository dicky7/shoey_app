import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/providers/auth_providers.dart';
import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/presentation/widget/custom_text_form.dart';
import 'package:shoes_app/utils/app_utils.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../utils/style/styles.dart';
import '../../providers/preferences_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = "/sign-up";
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController usernameEditingController = TextEditingController(text: "");
  final TextEditingController emailTextEditingController = TextEditingController(text: "");
  final TextEditingController fullNameTextEditingController = TextEditingController(text: "");
  final TextEditingController passwordTextEditingController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
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
                  "Create Your Account",
                  style: Theme.of(context).textTheme.headline5?.copyWith(color: kBlackColor, fontSize: 26),
                ),
                const SizedBox(height: 20),
                _inputSection(context),
                const SizedBox(height: 30),
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
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextForm(
              title: "Full Name",
              hintText: "Your Full Name" ,
              prefixIcons: const Icon(Icons.person),
              textEditingController: fullNameTextEditingController,
              errorText: "Please Input Your Full Name",
            ),
            const SizedBox(height: 10),
            CustomTextForm(
              title: "Username",
              hintText: "Your Username" ,
              prefixIcons: const Icon(Icons.person_outlined),
              textEditingController: usernameEditingController,
              errorText: "Please Input Your Username",
            ),
            const SizedBox(height: 10),
            CustomTextForm(
              title: "Email",
              hintText: "Your Email" ,
              prefixIcons: const Icon(Icons.email),
              textEditingController: emailTextEditingController,
              errorText: "Please Input Your Email",
            ),
            const SizedBox(height: 10),
            CustomTextForm(
              title: "Password",
              hintText: "Your Password" ,
              prefixIcons: const Icon(Icons.lock),
              textEditingController: passwordTextEditingController,
              errorText: "Please Input Your Password",
              obscureText: true,
            ),
            const SizedBox(height: 30),
            handleSignUp(context)
          ],
        ),
      ),
    );
  }

  Widget handleSignUp(BuildContext context){
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showCustomDialog(
            context: context,
            title: "Hurray :)",
            content: "Sign Up Success, Please Login First",
            buttonTitle: "Sign In",
            icons: Icons.check,
            onPressed: () => Navigator.pushNamed(context, SignInPage.routeName),
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
          title: "Sign Up",
          margin: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {
            if (_formKey.currentState?.validate() == false) {
              // Invalid!
              return;
            }
            _formKey.currentState?.save();
            context.read<AuthCubit>().signUp(
                name: fullNameTextEditingController.text,
                username: usernameEditingController.text,
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text
            );
          },
        );
      },
    );
  }



  Widget footer(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account ? ",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          child: Text(
            "Sign in",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: kGreenColor),
          ),
          onTap: () {
            Navigator.pushNamed(context, SignInPage.routeName);
          },
        )
      ],
    );
  }
}
