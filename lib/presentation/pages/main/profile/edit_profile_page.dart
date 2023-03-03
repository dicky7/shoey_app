import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/profile_page.dart';
import 'package:shoes_app/presentation/providers/profile/profile_providers.dart';
import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/presentation/widget/custom_text_form.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../../../utils/app_utils.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = "edit-profile";
  EditProfilePage({Key? key}) : super(key: key);

  final TextEditingController usernameEditingController = TextEditingController(text: "");
  final TextEditingController nameEditingController = TextEditingController(text: "");
  final TextEditingController emailEditingController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.5,
          toolbarHeight: 80,
          title: Text("Edit Profile", style: TextStyle(color: kBlackColor)),
          leading: BackButton(color: kBlackColor),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: buildInputSection(),
          ),
        ),
      ),
    );
  }

  Widget buildInputSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          CustomTextForm(
            title: "Full Name",
            hintText: "Your New Full Name",
            errorText: "Please Input Your Full Name",
            textEditingController: nameEditingController,
          ),
          const SizedBox(height: 15),
          CustomTextForm(
            title: "Username",
            hintText: "Your New Username",
            errorText: "Please Input Your Username",
            textEditingController: usernameEditingController,
          ),
          const SizedBox(height: 15),
          CustomTextForm(
            title: "Email",
            hintText: "Your New Email",
            errorText: "Please Input Your Email",
            textEditingController: emailEditingController,
          ),
          const SizedBox(height: 50),
          updateButton()
        ],
      ),
    );
  }

  Widget updateButton(){
    return Consumer<ProfileProviders>(
      builder: (context, value, child) {
        final state = value.stateUpdateUser;
        if (state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state == ResultState.Success){
          Future.microtask((){
            showCustomDialog(
              context: context,
              title: "Hurray :)",
              content: value.messageUpdateUser,
              buttonTitle: "Lets Go",
              icons: Icons.check,
              onPressed: () => Navigator.pushNamed(context, MainPage.routeName),
            );
            //set state to initial becasue if not the custom dialog will alwasys appear
            Provider.of<ProfileProviders>(context, listen: false).setPostState(ResultState.Initial);

          });
        } else if(state == ResultState.Error){
          Future.microtask((){
            showCustomDialogError(
              context: context,
              title: "Error",
              content: value.messageUpdateUser,
              icons: Icons.close,
            );
            //set state to initial becasue if not the custom dialog will alwasys appear
            Provider.of<ProfileProviders>(context, listen: false).setPostState(ResultState.Initial);
          });
          return Container();
        }return CustomButton(
          title: "Sign Up",
          margin: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Provider.of<ProfileProviders>(context, listen: false).updateUserProfile(
                  fullname: nameEditingController.text,
                  email: emailEditingController.text,
                  username: usernameEditingController.text,
              );
              Provider.of<ProfileProviders>(context, listen: false).setPostState(ResultState.Initial);
            }
          },
        );
      },
    );
  }
}
