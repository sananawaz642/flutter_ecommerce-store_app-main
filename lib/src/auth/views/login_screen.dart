
import 'package:bot_toast/bot_toast.dart';
import 'package:e_commerce_flutter/core/app_text_styles.dart';
import 'package:e_commerce_flutter/src/auth/controller/auth_controller.dart';
import 'package:e_commerce_flutter/src/auth/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_regex.dart';
import 'widgets/gradient_bg.dart';
import 'widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  final ValueNotifier<bool> isAdmin = ValueNotifier(false);

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientBackground(
            children: [
              Text(
                'Sign In',
                style: AppTextStyles.authStyle
              ),
              const SizedBox(height: 6),
              Text('Sign in if you are already registered', style: AppTextStyles.authStyle.copyWith(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 50),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    controller: emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? 'please Enter EmailAddress'
                          :  null;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return AppTextFormField(
                        obscureText: passwordObscure,
                        controller: passwordController,
                        labelText: 'Password',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? 'please Enter Password'
                              : null
                            ;
                        },
                        suffixIcon: IconButton(
                          onPressed: () =>
                              passwordNotifier.value = !passwordObscure,
                          style: IconButton.styleFrom(
                            minimumSize: const Size.square(48),
                          ),
                          icon: Icon(
                            passwordObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forget password'),
                  ),
                  // ValueListenableBuilder(
                  //   valueListenable: isAdmin,
                  //   builder: (context, val, child) {
                  //     return CheckboxListTile(value: isAdmin.value, onChanged: (val){
                  //       // setState(() {
                  //         isAdmin.value = val!;
                  //       // });
                  //     });
                  //   }
                  // ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: fieldValidNotifier,
                    builder: (_, isValid, __) {
                      return FilledButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            BotToast.showLoading();
                            await Get.find<AuthController>().loginWithEmailAndPassword(emailAddress: emailController.text, password: passwordController.text);
                            BotToast.closeAllLoading();
                          }
                        },
                        child: const Text('Login'),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do not have a account?',
                style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
              // const SizedBox(width: 2),
              TextButton(
                onPressed: () {
                  Get.to(const RegisterPage());
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}