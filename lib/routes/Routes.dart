import 'package:exchange_books/models/DetailsBookScreenModel.dart';
import 'package:exchange_books/pages/add_book/AddBookScreen.dart';
import 'package:exchange_books/pages/add_book/AddBookViewModel.dart';
import 'package:exchange_books/pages/details_book/DetailsBookScreen.dart';
import 'package:exchange_books/pages/details_book/DetailsBookViewModel.dart';
import 'package:exchange_books/pages/home/HomeScreen.dart';
import 'package:exchange_books/pages/home/HomeViewModel.dart';
import 'package:exchange_books/pages/login/LoginScreen.dart';
import 'package:exchange_books/pages/login/LoginViewModel.dart';
import 'package:exchange_books/pages/registration/RegistrationScreen.dart';
import 'package:exchange_books/pages/registration/RegistrationViewModel.dart';
import 'package:exchange_books/pages/user/UserScreen.dart';
import 'package:exchange_books/pages/user/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class Routes{
  static final sailor = Sailor(
    options: SailorOptions(
      defaultTransitions: [SailorTransition.slide_from_right]));


  //Routes names
  static const home = "/home";
  static const login = "/login";
  static const registration = "/registration";
  static const detailsBook = "/detailsBook";
  static const addBook = "/addBook";
  static const user = "/user";

  static void createRoutes(){
    //TODO
    sailor.addRoute(SailorRoute(
        name: login,
        builder: (context, args, params){
          return ChangeNotifierProvider<LoginViewModel>(
              create: (_) =>
                  LoginViewModel(),
              child: LoginScreen());
        }));

    sailor.addRoute(SailorRoute(
        name: registration,
        builder: (context, args, params){
          return ChangeNotifierProvider<RegistrationViewModel>(
              create: (_) =>
                  RegistrationViewModel(),
              child: RegistrationScreen());
        }));

    sailor.addRoute(SailorRoute(
        name: home,
        builder: (context, args, params){
          return ChangeNotifierProvider<HomeViewModel>(
              create: (_) => HomeViewModel(),
              child: HomeScreen());
        }));

    sailor.addRoute(SailorRoute(
        name: detailsBook,
        builder: (context, args, params){
          return ChangeNotifierProvider<DetailsBookViewModel>(
              create: (_) => DetailsBookViewModel(params.param('bookModel')),
              child: DetailsBookScreen());
        },
        params:[
          SailorParam<DetailsBookScreenModel>(name: 'bookModel', isRequired: true)
        ]));

    sailor.addRoute(SailorRoute(
        name: addBook,
        builder: (context, args, params){
          return ChangeNotifierProvider<AddBookViewModel>(
              create: (_) => AddBookViewModel(),
              child: AddBookScreen());
        }));

    sailor.addRoute(SailorRoute(
        name: user,
        builder: (context, args, params){
          return ChangeNotifierProvider<UserViewModel>(
              create: (_) => UserViewModel(),
              child: UserScreen());
        }));
  }

}