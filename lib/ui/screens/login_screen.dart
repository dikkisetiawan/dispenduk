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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  } else if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kWarningColor,
                        content: Text(
                          state.error,
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
}
