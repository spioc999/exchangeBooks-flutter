import 'dart:io';
import 'dart:math';

import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){

  group('ExchangeBook', (){

    final backFinder = find.byValueKey(ExchangeBooksValueKey.back);

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      await Process.run('adb' , ['shell' ,'pm', 'grant', 'it.spioc.exchange_books', 'android.permission.CAMERA'], runInShell: true,);
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Register', ()async{

      final registerButtonFinder = find.byValueKey(ExchangeBooksValueKey.registerButton);
      final firstNameFinder = find.byValueKey(ExchangeBooksValueKey.firstNameTextFieldRegister);
      final lastNameFinder = find.byValueKey(ExchangeBooksValueKey.lastNameTextFieldRegister);
      final usernameFinder = find.byValueKey(ExchangeBooksValueKey.usernameTextFieldRegister);
      final emailFinder = find.byValueKey(ExchangeBooksValueKey.emailTextFieldRegister);
      final passwordFinder = find.byValueKey(ExchangeBooksValueKey.passwordTextFieldRegister);
      final repeatPasswordFinder = find.byValueKey(ExchangeBooksValueKey.repeatPasswordTextFieldRegister);
      final cityFinder = find.byValueKey(ExchangeBooksValueKey.cityTextFieldRegister);
      final provinceFinder = find.byValueKey(ExchangeBooksValueKey.provinceTextFieldRegister);
      final goRegisterFinder = find.byValueKey(ExchangeBooksValueKey.goButtonRegister);
      final registerCompleted = find.byValueKey(ExchangeBooksValueKey.registerCompleted);

      await driver.waitFor(find.text(Strings.login));

      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(registerButtonFinder);

      await driver.waitFor(find.text(Strings.registrationTitle));

      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(firstNameFinder);
      await driver.enterText("Test Name");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(lastNameFinder);
      await driver.enterText("Test Surname");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(usernameFinder);
      await driver.enterText("user name");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(emailFinder);
      await driver.enterText("email");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(passwordFinder);
      await driver.enterText("password");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(repeatPasswordFinder);
      await driver.enterText("passwor");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(cityFinder);
      await driver.enterText("Paceco");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(provinceFinder);
      await driver.enterText("TP");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(goRegisterFinder);
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(usernameFinder);
      await driver.enterText("test");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(emailFinder);
      await driver.enterText("email@test.com");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(passwordFinder);
      await driver.enterText("Password8");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(repeatPasswordFinder);
      await driver.enterText("Password8");
      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(goRegisterFinder);
      await Future.delayed(Duration(milliseconds: 400));

      await driver.waitFor(registerCompleted);
      await Future.delayed(Duration(milliseconds: 500));
      await driver.tap(registerCompleted);

      await driver.waitFor(find.text(Strings.login));

    });

    test('Login', ()async{

      final emailLoginFinder = find.byValueKey(ExchangeBooksValueKey.emailTextFieldLogin);
      final passwordLoginFinder = find.byValueKey(ExchangeBooksValueKey.passwordTextFieldLogin);
      final loginButtonFinder = find.byValueKey(ExchangeBooksValueKey.loginButton);
      final rememberMeCheckBoxFinder = find.byValueKey(ExchangeBooksValueKey.showPasswordButtonLogin);

      await driver.tap(emailLoginFinder);

      await driver.enterText("email@test.com");

      await driver.tap(passwordLoginFinder);

      await driver.enterText("Password8");

      await driver.tap(rememberMeCheckBoxFinder);
      await Future.delayed(Duration(milliseconds: 100));
      await driver.tap(rememberMeCheckBoxFinder);

      await driver.tap(loginButtonFinder);

      await driver.waitFor(find.text(Strings.booksInNearby));

    });

    test('Home', ()async{

      final getInfoButtonFinder = find.byValueKey(ExchangeBooksValueKey.infoButtonHome);
      final bottomSheetInfoFinder = find.byValueKey(ExchangeBooksValueKey.infoBottomSheetHome);
      final searchFinder = find.byValueKey(ExchangeBooksValueKey.searchHome);
      final bookListFinder = find.byValueKey(ExchangeBooksValueKey.bookListHome);
      final firstBookFinder = find.byValueKey(ExchangeBooksValueKey.bookHome + "_0");

      await driver.tap(getInfoButtonFinder);

      await driver.waitFor(bottomSheetInfoFinder);

      await Future.delayed(Duration(milliseconds: 200));

      await driver.scroll(bottomSheetInfoFinder, 0, 300, Duration(milliseconds: 500));

      await Future.delayed(Duration(milliseconds: 200));

      await driver.scroll(bookListFinder, 0, -500, Duration(milliseconds: 400));
      await Future.delayed(Duration(milliseconds: 200));
      await driver.scroll(bookListFinder, 0, 500, Duration(milliseconds: 400));
      await Future.delayed(Duration(milliseconds: 200));
      await driver.scroll(bookListFinder, 0, 300, Duration(milliseconds: 400));

      await Future.delayed(Duration(milliseconds: 1000));

      await driver.tap(searchFinder);
      await driver.enterText("Probabilità");
      await Future.delayed(Duration(milliseconds: 200));
      await driver.tap(firstBookFinder);

      await driver.waitFor(find.text(Strings.owner));

    });

    test('Book Details', ()async{

      final contactButtonFinder = find.byValueKey(ExchangeBooksValueKey.contactButtonDetails);

      await driver.scroll(find.text(Strings.owner), 0, -300, Duration(milliseconds: 500));
      await Future.delayed(Duration(milliseconds: 100));


      await driver.tap(contactButtonFinder);
      await Future.delayed(Duration(milliseconds: 2000));

      await goBack();

      await driver.scroll(find.text(Strings.owner), 0, 300, Duration(milliseconds: 500));

      await driver.tap(backFinder);

      await Future.delayed(Duration(milliseconds: 500));


    });

    test('User Page', () async {

      final userButtonFinder = find.byValueKey(ExchangeBooksValueKey.userButtonHome);

      await driver.tap(userButtonFinder);

      await driver.waitFor(find.text(Strings.noBooksYet));

      await Future.delayed(Duration(milliseconds: 1000));

      await driver.tap(backFinder);

      await Future.delayed(Duration(milliseconds: 500));

    });

    test('Add Book', () async {

      final addButtonFinder = find.byValueKey(ExchangeBooksValueKey.addButtonHome);
      final searchFinder = find.byValueKey(ExchangeBooksValueKey.searchHome);
      final isbnTextFieldFinder = find.byValueKey(ExchangeBooksValueKey.isbnTextFieldAddBook);
      final scanButtonFinder = find.byValueKey(ExchangeBooksValueKey.scanBarCodeButtonAddBook);
      final nextButton = find.byValueKey(ExchangeBooksValueKey.nextButtonAddBook);
      final notesTextField = find.byValueKey(ExchangeBooksValueKey.notesTextFieldAddBook);
      final addButton = find.byValueKey(ExchangeBooksValueKey.addButtonAddBook);
      final addCompleted = find.byValueKey(ExchangeBooksValueKey.addCompletedAddBook);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(searchFinder);
      await driver.enterText("");
      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(addButtonFinder);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(scanButtonFinder);

      await Future.delayed(Duration(milliseconds: 1000));

      await goBack();
      
      await Future.delayed(Duration(milliseconds: 500));
      
      await driver.tap(isbnTextFieldFinder);
      
      await driver.enterText("9788850334384");
      await driver.tap(nextButton);

      await driver.waitFor(notesTextField);

      await driver.tap(notesTextField);
      await driver.enterText("Ottimo stato");

      await Future.delayed(Duration(milliseconds: 400));

      await driver.tap(addButton);

      await driver.waitFor(addCompleted);

      await Future.delayed(Duration(milliseconds: 1000));

      await driver.tap(addCompleted);

      await driver.waitFor(find.text(Strings.yourData));

    });

    test('User Books', () async{

      final firstBookItemFinder = find.byValueKey(ExchangeBooksValueKey.bookItemUser + "_0");
      final editButton = find.byValueKey(ExchangeBooksValueKey.editButtonDetails);
      final deleteButton = find.byValueKey(ExchangeBooksValueKey.deleteButtonDetails);
      final yesButton = find.byValueKey(ExchangeBooksValueKey.yesButtonDetails);
      final noButton = find.byValueKey(ExchangeBooksValueKey.noButtonDetails);
      final option1Edit = find.byValueKey(ExchangeBooksValueKey.editOptionButtonDetails + "_0");
      final logoutButton = find.byValueKey(ExchangeBooksValueKey.logoutUser);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.waitFor(firstBookItemFinder);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(firstBookItemFinder);

      await driver.waitFor(editButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(editButton);

      await driver.waitFor(option1Edit);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(option1Edit);

      await driver.waitFor(firstBookItemFinder);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(firstBookItemFinder);

      await driver.waitFor(deleteButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(deleteButton);

      await driver.waitFor(noButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(noButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(deleteButton);

      await driver.waitFor(yesButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(yesButton);

      await driver.waitFor(logoutButton);

      await Future.delayed(Duration(milliseconds: 500));

      await driver.tap(logoutButton);

      await driver.waitFor(find.text(Strings.login));

      await Future.delayed(Duration(milliseconds: 2000));

    });

  }, timeout: Timeout(Duration(minutes: 5)));

}

Future<void> goBack() async{
  await Process.run(
    'adb',
    <String>['shell', 'input', 'keyevent', 'KEYCODE_BACK'],
    runInShell: true,
  );
}