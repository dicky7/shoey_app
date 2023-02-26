import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/presentation/widget/custom_text_form.dart';
import 'package:shoes_app/utils/style/styles.dart';

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
            textEditingController: usernameEditingController,
          ),
          const SizedBox(height: 50),
          updateButton()
        ],
      ),
    );
  }

  Widget updateButton(){
    return CustomButton(
      title: "Update",
      onPressed: () {
        if (_formKey.currentState!.validate()) {

        }
      },
    );
  }
}
