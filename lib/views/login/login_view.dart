import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/theme/app_colors.dart';
import 'package:trinity_wizard/views/login/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel vm = Get.find<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 53,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text.rich(
              TextSpan(
                text: 'Hi There!\n',
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Please login to see your contact list',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7f7f7f),
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 20 / 16,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            height: 41,
          ),
          _Form(),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    // ignore: unused_element
    super.key,
  });

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final LoginViewModel vm = Get.find<LoginViewModel>();

  final TextEditingController _credentialController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _credentialController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Username ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 21 / 14,
                  ),
                ),
                TextSpan(
                  text: '* ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Color(0xffED1C2E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _credentialController,
            decoration: InputDecoration(
              hintText: 'Enter your id/email',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          const Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Password ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 21 / 14,
                  ),
                ),
                TextSpan(
                  text: '* ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Color(0xffED1C2E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const SizedBox(
            height: 57,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                vm.login(
                  credential: _credentialController.text,
                  password: _passwordController.text,
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color(0x1A96D3F2),
                foregroundColor: AppColors.primary,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
