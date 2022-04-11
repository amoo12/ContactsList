import 'package:contact_list/wrapper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'contacts_feature/contact_details_view.dart';
import 'contacts_feature/contact_list_view.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: FlexThemeData.light(scheme: FlexScheme.sakura),
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.rosewood,
            darkIsTrueBlack: false,
            appBarStyle: FlexAppBarStyle.primary,
          ),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case ContactDetailsView.routeName:
                    return ContactDetailsView();
                  case ContactListView.routeName:
                  default:
                    return Wrapper();
                }
              },
            );
          },
        );
      },
    );
  }
}
