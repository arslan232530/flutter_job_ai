import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/controllers/auth/is_password.dart';
import 'package:job_board/controllers/auth/signup/signup_notifier.dart';
import 'package:job_board/controllers/auth/signup/signup_provider.dart';
import 'package:job_board/helper/ui_helper.dart';
import 'package:job_board/models/request/auth/signup_model.dart';
import 'package:job_board/services/auth/password_service.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_btn/custom_btn.dart';
import 'package:job_board/views/custom/custom_text/custom_textfield.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final registerProvider = ref.watch(signupProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          text: 'Signup',
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: !ref.watch(signupProvider).isLoading
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const HeightSpacer(size: 50),
                    ReusableText(
                      text: 'Hello, Welcome',
                      style: appstyle(
                        40,
                        theme.colorScheme.onSurface,
                        FontWeight.w600,
                      ),
                    ),
                    ReusableText(
                      text: 'Fill the details to signup for an account',
                      style: appstyle(
                        17,
                        theme.colorScheme.secondary,
                        FontWeight.w600,
                      ),
                    ),
                    const HeightSpacer(size: 50),
                    CustomTextField(
                      controller: name,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Full Name',
                      validator: (name) {
                        if (name!.isEmpty || email.text.trim().length <= 4) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      validator: (email) {
                        if (email!.isEmpty || !email.contains('@')) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
                    Consumer(
                      builder: (context, ref, child) {
                        final isVisible = ref.watch(passwordVisibleProvider);
                        return CustomTextField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          hintText: 'Password',
                          obscureText: isVisible,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Password is required';
                            }

                            if (!PasswordService.isStrong(password)) {
                              return 'Password must be at least 8 characters, include uppercase, lowercase, number and special character';
                            }

                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              ref.read(passwordVisibleProvider.notifier).state =
                                  !isVisible;
                            },
                            child: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    const HeightSpacer(size: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.push('/login');
                        },
                        child: ReusableText(
                          text: 'Login',
                          style: appstyle(
                            16,
                            theme.colorScheme.onSurface,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const HeightSpacer(size: 50),
                    CustomButton(
                      onTap: () async {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;

                        if (!isValid) {
                          UIHelper.showErrorSnackBar(
                            context,
                            'Please check your credentials',
                          );
                          return;
                        }

                        final model = SignupModel(
                          username: name.text.trim(),
                          email: email.text.trim(),
                          password: password.text.trim(),
                        );

                        final result = await ref
                            .read(signupProvider.notifier)
                            .signupUser(model);

                        if (!mounted) return;

                        switch (result) {
                          case SignupResult.success:
                            context.push('/login');
                            break;

                          case SignupResult.failure:
                            final error =
                                ref.read(signupProvider).error ??
                                'Signup failed';
                            UIHelper.showErrorSnackBar(context, error);
                            break;
                        }
                      },

                      text: 'Register',
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
