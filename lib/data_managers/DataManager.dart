import 'package:exchange_books/data_managers/DataManagerBook.dart';
import 'package:exchange_books/data_managers/DataManagerUser.dart';

class DataManager {

  DataManagerUser _managerUser;
  DataManagerBook _managerBook;

  ///DATA MANAGER USER
  DataManagerUser get managerUser {
    if(_managerUser == null) _managerUser = DataManagerUser();
    return _managerUser;
  }

  ///DATA MANAGER BOOK
  DataManagerBook get managerBook {
    if(_managerBook == null) _managerBook = DataManagerBook();
    return _managerBook;
  }
}