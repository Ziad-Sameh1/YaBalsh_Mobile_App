import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/register_request_model.dart';
import 'package:yabalash_mobile_app/features/auth/presentation/widgets/account_problem_bottom_bar.dart';
import 'package:yabalash_mobile_app/features/auth/presentation/widgets/auth_back_icon.dart';
import 'package:yabalash_mobile_app/features/auth/presentation/widgets/auth_title_widget.dart';
import 'package:yabalash_mobile_app/features/auth/presentation/widgets/register_form.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/widgets/ya_balash_custom_button.dart';
import '../blocs/cubit/register_cubit.dart';
import 'privacy_policy_text.dart';

class RegisterBody extends StatefulWidget {
  final String phoneNumber;
  final String fromRoute;
  const RegisterBody(
      {super.key, required this.phoneNumber, required this.fromRoute});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: kDefaultPadding,
        child: KeyboardVisibilityBuilder(builder: (context, isVisible) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: isVisible ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthBackIcon(),
                      mediumVerticalSpace,
                      const AuthTitleWidget(
                        title: 'إنشاء حساب جديد',
                      ),
                      largeVerticalSpace,

                      RegisterForm(
                          formKey: _formKey, phoneNumber: widget.phoneNumber),

                      largeVerticalSpace,
                      largeVerticalSpace,

                      // register button

                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return YaBalashCustomButton(
                            isDisabled: state.isButtonDisabled,
                            onTap: () {
                              if (!state.isButtonDisabled!) {
                                if (_formKey.currentState!.validate()) {
                                  handleValidRegsiterRequest(context);
                                } else if (!_formKey.currentState!
                                    .fields['password']!.isValid) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .changeFormFieldError(true);
                                }
                              }
                            },
                            child: const Text('انشاء الحساب'),
                          );
                        },
                      ),
                      mediumVerticalSpace,
                      const PrivacyPolicyText(),
                      SizedBox(
                        height: isVisible ? Get.width * 0.4 : 0,
                      )
                    ],
                  ),
                ),
              ),
              const AccountProblemBottomBar()
            ],
          );
        }),
      ),
    );
  }

  void handleValidRegsiterRequest(BuildContext context) {
    BlocProvider.of<RegisterCubit>(context).changeFormFieldError(false);
    RegisterRequestModel? registerBody;
    String? email;

    email = _formKey.currentState!.fields['email']!.value != null &&
            _formKey.currentState!.fields['email']!.value != ''
        ? _formKey.currentState!.fields['email']!.value.toString().trim()
        : '${_formKey.currentState!.fields['phoneNumber']!.value}@yabalash.net';

    registerBody = RegisterRequestModel(
        email: email,
        firstName:
            _formKey.currentState!.fields['firstName']!.value.toString().trim(),
        lastName:
            _formKey.currentState!.fields['lastName']!.value.toString().trim(),
        password:
            _formKey.currentState!.fields['password']!.value.toString().trim(),
        phoneNumber: _formKey.currentState!.fields['phoneNumber']!.value
            .toString()
            .trim());

    BlocProvider.of<RegisterCubit>(context).registerUser(
        registerCredntials: registerBody, fromRoute: widget.fromRoute);
  }
}
