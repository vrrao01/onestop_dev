import 'package:onestop_dev/pages/quick_link/blogs_page.dart';
import 'package:onestop_dev/pages/home/body/food/search_results.dart';
import 'package:onestop_dev/pages/home/home_routes.dart';
import 'package:onestop_dev/pages/login.dart';
import 'package:onestop_dev/pages/qr.dart';
import 'package:onestop_dev/pages/quick_link/contact/contact.dart';
import 'package:onestop_dev/pages/quick_link/ip/ip_carousel.dart';
import 'package:onestop_dev/pages/quick_link/lost_found/lnf_home.dart';
import 'package:onestop_dev/pages/splash.dart';

final routes = {
  SplashPage.id: (context) => const SplashPage(),
  QRPage.id: (context) => const QRPage(),
  LoginPage.id: (context) => const LoginPage(),
  HomePage.id: (context) => const HomePage(),
  RouterPage.id: (context) => RouterPage(),
  Blogs.id: (context) => const Blogs(),
  SearchPage.id: (context) => const SearchPage(),
  LostFoundHome.id: (context) => LostFoundHome(),
  ContactPage.id: (context) => ContactPage(),
};
