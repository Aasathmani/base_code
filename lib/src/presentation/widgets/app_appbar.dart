import 'package:flutter/material.dart';
import 'package:app_task/generated/l10n.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';

class AppAppbar extends PreferredSize {
  AppAppbar({
    super.key,
    required VoidCallback onUserTap,
    required bool isBackButtonRequired,
    String? screen,
    String? title,
    List<Widget> actions = const [],
    Widget? leading,
  }) : super(
          preferredSize: const Size.fromHeight(Units.kAppBarHeight),
          child: _AppAppbar(
            key: key,
            onUserTap: onUserTap,
            shouldShowBackIcon: isBackButtonRequired,
            screen: screen,
            title: title,
            actions: actions,
            leading: leading,
          ),
        );
}

class _AppAppbar extends StatelessWidget {
  final String? screen;
  final VoidCallback onUserTap;
  final String? title;
  final bool shouldShowBackIcon;
  final List<Widget> actions;
  final Widget? leading;

  const _AppAppbar({
    super.key,
    required this.onUserTap,
    required this.shouldShowBackIcon,
    this.screen,
    this.title,
    this.actions = const [],
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: Units.kAppBarHeight,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      key: key,
      elevation: 0,
      automaticallyImplyLeading: shouldShowBackIcon,
      backgroundColor: AppColors.darkWhite,
      titleSpacing: 0,
      title: Text(
        title ?? S.current.labelFESProject,
        style: TextStyles.h3(context)?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      leading: leading,
      actions: [
        if (actions.isNotEmpty) ...actions,

        /// todo: need it for next design changes
        //   IconButton(
        //     padding: EdgeInsets.zero,
        //     icon: const Icon(Icons.menu_rounded),
        //     iconSize: Units.kAppIconSizeLarge,
        //     color: Colors.black,
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //   )
      ],
    );
  }
}
