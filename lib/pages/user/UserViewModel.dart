import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/models/DetailsBookScreenModel.dart';
import 'package:exchange_books/models/User.dart';
import 'package:exchange_books/network/modelsBooks/GetBooksResult.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class UserViewModel extends BaseViewModel{

  User user;
  List<GetBooksResult> myBooks;

  Future<void> init(BuildContext context) async{

    DataManager dm = DataManager();

    if(user == null){
      var dmrUser = await dm.managerUser.getCurrentUser();

      if(dmrUser.hasError()) return;

      user = dmrUser.response;

      notifyListeners();
    }

    this.showProgress();

    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      return;
    }

    var dmr = await dm.managerBook.getBooks(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response
    );

    this.dismissProgress();

    if(dmr.hasError()){
      showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorMessage, AlertType.error);
      return;
    }

    myBooks = dmr.response.result;
    notifyListeners();

  }

  void onPressLogout() async{
    DataManager dm = DataManager();

    await dm.managerUser.logout();

    Routes.sailor.navigate(Routes.login, navigationType: NavigationType.pushAndRemoveUntil, removeUntilPredicate: (_) => false);

  }

  void onClickBook(int index, BuildContext context) async{

    GetBooksResult bookSelected = myBooks[index];

    DetailsBookScreenModel model = DetailsBookScreenModel(
        isOwned: true,
        imageLink: bookSelected.thumbnailLink,
        authors: bookSelected.authors,
        publishedDate: bookSelected.publishedDate,
        bookStatus: bookSelected.bookStatus,
        isbn: bookSelected.isbn,
        note: bookSelected.note,
        dateInsertion: bookSelected.dateInsertion,
        id: bookSelected.id,
        username: "",
        email: "",
        lastName: "",
        firstName: "",
        city: "",
        title: bookSelected.title
    );


    bool shouldReload = await Routes.sailor.navigate(Routes.detailsBook, params: {
      'bookModel' : model
    });

    if(shouldReload == null) return;

    if(shouldReload)
      init(context);

  }

}