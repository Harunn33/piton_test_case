import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piton_test_case/core/constants/app_colors.dart';
import 'package:piton_test_case/core/enums/app_icons.dart';
import 'package:piton_test_case/core/enums/input_type.dart';
import 'package:piton_test_case/core/extensions/context_ext.dart';
import 'package:piton_test_case/core/widgets/buttons/custom_primary_button.dart';
import 'package:piton_test_case/core/widgets/buttons/custom_text_button.dart';
import 'package:piton_test_case/core/widgets/inputs/custom_primary_input.dart';
import 'package:piton_test_case/features/auth/data/model/login/req/login_request_model.dart';
import 'package:piton_test_case/features/auth/presentation/pages/login/mixin/login_mixin.dart';
import 'package:piton_test_case/features/auth/presentation/providers/auth_notifier.dart';
import 'package:piton_test_case/features/language/presentation/pages/language_popup_menu.dart';

part 'widgets/custom_checkbox.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.instance.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: appPaddings.horizontal,
            child: const LanguagePopupMenu(),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: state.formKey,
          child: Padding(
            padding: appPaddings.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AppIcons.icLogo.svgWithAttiributes(
                    color: AppColors.instance.majorelleBlue,
                    height: 65.h,
                  ),
                ),
                const Spacer(),
                Text(
                  context.l10n.welcomeBack,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.instance.cosmicVoid.withOpacity(.6),
                      ),
                ),
                10.verticalSpace,
                Text(
                  context.l10n.loginToYourAccount,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                CustomPrimaryInput(
                  label: context.l10n.email,
                  hintText: appStrings.hintEmail,
                  controller: emailController,
                  inputType: InputType.email,
                ),
                20.verticalSpace,
                CustomPrimaryInput(
                  label: context.l10n.password,
                  hintText: appStrings.hintPassword,
                  controller: passwordController,
                  inputType: InputType.password,
                ),
                10.verticalSpace,
                Row(
                  children: [
                    const _CustomCheckbox(),
                    const Spacer(),
                    CustomTextButton(
                      text: context.l10n.register,
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      onPressed: () => notifier.navigateToRegister(context),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
                CustomPrimaryButton(
                  text: context.l10n.login,
                  isLoading: state.isLoading,
                  onPressed: () {
                    notifier.handleLogin(
                      context,
                      loginRequestModel: LoginRequestModel(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}