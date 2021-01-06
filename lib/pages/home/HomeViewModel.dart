import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/models/DetailsBookScreenModel.dart';
import 'package:exchange_books/network/modelsBooks/SearchBooksResult.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:sailor/sailor.dart';

class HomeViewModel extends BaseViewModel {

  String name;
  String province;
  String filter;
  List<SearchBooksResult> books;
  List<SearchBooksResult> filteredBooks;

  String version;

  TextEditingController searchController = TextEditingController();

  Future<void> init(BuildContext context, {bool shoulShowProgress = true}) async {
    
    filter = null;
    searchController.text = "";

    DataManager dm = DataManager();

    if(shoulShowProgress) this.showProgress();

    if(name == null || province == null){
      var dmrUser = await dm.managerUser.getCurrentUser();

      name = dmrUser.response.firstName;
      province = dmrUser.response.province;

      notifyListeners();
    }


    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      return;
    }

    var dmrBooks = await dm.managerBook.searchBooks(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response
    );

    this.dismissProgress();

    if(dmrBooks.hasError()){
      showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorMessage, AlertType.error);
      return;
    }

    books = dmrBooks.response.result;
    filteredBooks = books;

    notifyListeners();

  }

  void onChangeFilter(String newValue) {
    this.filter = newValue;
    _filterBooks();
    notifyListeners();
  }

  void _filterBooks() {

    if(this.filter == null || this.filter.isEmpty){
      filteredBooks = books;
    }else{
      filteredBooks = books.where((element) => element.title.toLowerCase().startsWith(filter.toLowerCase()) || element.isbn.startsWith(filter)).toList();
    }

  }

  Future<void> getVersion() async{

    if(version != null) return;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;

  }

  void onClickBook(int index) {

    SearchBooksResult bookClicked = filteredBooks[index];

    DetailsBookScreenModel model = DetailsBookScreenModel(
      isOwned: false,
      imageLink: bookClicked.thumbnailLink,
      authors: bookClicked.authors,
      publishedDate: bookClicked.publishedDate,
      city: bookClicked.city,
      bookStatus: bookClicked.bookStatus,
      isbn: bookClicked.isbn,
      note: bookClicked.note,
      dateInsertion: bookClicked.dateInsertion,
      username: bookClicked.username,
      email: bookClicked.email,
      lastName: bookClicked.lastName,
      firstName: bookClicked.firstName,
      title: bookClicked.title
    );

    Routes.sailor.navigate(Routes.detailsBook, params: {
      'bookModel' : model
    });
  }

  void onPressAdd(){
    //TODO

    Routes.sailor.navigate(Routes.addBook);

  }

  void onPressUser() async{

    Routes.sailor.navigate(Routes.user);

  }

}

