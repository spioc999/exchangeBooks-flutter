import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/network/modelsBooks/BooksDetailsResult.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/AppValidators.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sailor/sailor.dart';

class AddBookViewModel extends BaseViewModel{

  static final String NULL_FROM_SCAN = "-1";

  TextEditingController isbnController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  String isbn;

  bool errorIsbn = false;
  bool errorHttpIsbn = false;

  BooksDetailsResult bookFound;

  String notes;

  void init(BuildContext context) {}


  void onChangeIsbn(String newValue){
    this.isbn = newValue;
    errorIsbn = false;
    errorHttpIsbn = false;
    bookFound = null;
    notifyListeners();
  }

  void onChangeNotes(String newValue){
    this.notes = newValue;
    notifyListeners();
  }
  
  void checkIsbnLength(){
    if(isbn == null || isbn.isEmpty)
      return;

    errorIsbn = !AppValidators.isbnValidator.hasMatch(isbn);
    notifyListeners();

  }
  
  bool isValidNote(){
    if(notes == null || notes.isEmpty) return false;

    return notes.trim().isNotEmpty;
  }

  void onClickAdd(BuildContext context) async{

    DataManager dm = DataManager();

    this.showProgress();

    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      return;
    }

    var dmr = await dm.managerBook.addNewBook(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response,
        idBook: bookFound.id,
        note: notes
    );

    this.dismissProgress();

    if(dmr.hasError()){
      showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorTitle, AlertType.error);
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: () async => false,
            child: ListTile(
              key: ValueKey(ExchangeBooksValueKey.addCompletedAddBook),
              contentPadding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
              leading: Icon(Icons.check_circle, color: Colors.green,),
              title: BoldText(Strings.operationCompleted),
              onTap: (){
                Routes.sailor.navigate(
                    Routes.user,
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: ModalRoute.withName(Routes.home)
                );
              },
            ),
          );
        },
        isDismissible: false,
        enableDrag: false
    );


  }

  void onClickScan(BuildContext context) async {

    errorIsbn = false;
    errorHttpIsbn = false;
    notifyListeners();
    
    String valueFromScan = await FlutterBarcodeScanner.scanBarcode("#4793d7", Strings.back, false, ScanMode.BARCODE);
    
    if(valueFromScan == null || valueFromScan == NULL_FROM_SCAN){
      return;
    }


    if(AppValidators.isbnValidator.hasMatch(valueFromScan)){

      isbn = valueFromScan;
      isbnController.text = isbn;
      notifyListeners();
      getInfoBook(context);

    }else{
      errorIsbn = true;
      isbn = valueFromScan;
      isbnController.text = isbn;
      notifyListeners();
    }

  }

  void getInfoBook(BuildContext context) async{

    if(isbn == null || !AppValidators.isbnValidator.hasMatch(isbn)){
      return;
    }

    DataManager dm = DataManager();

    this.showProgress();

    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      errorIsbn = true;
      errorHttpIsbn = true;
      notifyListeners();
      return;
    }

    var dmr = await dm.managerBook.getBooksDetailsByIsbn(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response,
        isbn: isbn
    );

    this.dismissProgress();

    if(dmr.hasError()){
      errorIsbn = true;
      errorHttpIsbn = true;
      notifyListeners();
      return;
    }

    bookFound = dmr.response.result;
    notifyListeners();

  }
}