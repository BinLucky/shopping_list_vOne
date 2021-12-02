import 'package:flutter/widgets.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';
import 'package:shopping_list_vone/login/login_page.dart';
import 'package:shopping_list_vone/home/home.dart';

List<Page> onGenerateAppViewPages(
    AppStatus appState, List<Page<dynamic>> pages) {
  switch (appState) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    default:
      return [LoginPage.page()];
  }
}
