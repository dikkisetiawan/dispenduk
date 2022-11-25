import 'package:dispenduk/ui/screens/konfirmasi_request_layanan_screen.dart';

import '/ui/widgets/kprimary_button_widget.dart';
import '/ui/widgets/ktext_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../theme.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController;
    passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login to your\naccount', style: blackTextStyle),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                ],
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              Form(
                child: Column(
                  children: [
                    KtextFieldWidget(
                      hintText: 'Email',
                      suffixIcon: const SizedBox(),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    KtextFieldWidget(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      suffixIcon: IconButton(
                        color: kDarkGreyColor,
                        splashRadius: 1,
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: togglePassword,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              KonfirmasiRequestLayananScreen(),
                        ),
                        (route) => false);
                  } else if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: kWarningColor,
                        content: Text(
                          state.error,
                          style: whiteTextStyle,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return loginButtonWidget(context);
                },
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              Center(
                child: Text(
                  'OR',
                  style: greyTextStyle,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              KprimaryButtonWidget(
                buttonColor: kWhiteColor,
                textValue: 'Login with Google',
                textColor: kBlackColor,
                onPressed: () {},
              ),
              const SizedBox(
                height: defaultMargin * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: greyTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      'Register',
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }

  KprimaryButtonWidget loginButtonWidget(BuildContext context) {
    return KprimaryButtonWidget(
      buttonColor: kPrimaryColor,
      textValue: 'Login',
      textColor: Colors.white,
      onPressed: () {
        context.read<AuthCubit>().signIn(
              email: 'test@email.com',
              password: '123456',
            );
      },
    );
  }
}
