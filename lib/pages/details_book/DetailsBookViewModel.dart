import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseViewModel.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/models/AppAlertModel.dart';
import 'package:exchange_books/models/DetailsBookScreenModel.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/button/AppButton.dart';
import 'package:exchange_books/widgets/button/OutlineAppButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsBookViewModel extends BaseViewModel{

  DetailsBookScreenModel model;

  DetailsBookViewModel(this.model);
  
  List<Widget> bookStatuses;

  void init(BuildContext context) async{
    
    bookStatuses = List();
    
    bookStatuses.add(_createWidgetByStatusId(1, context));
    bookStatuses.add(_createWidgetByStatusId(2, context));
    bookStatuses.add(_createWidgetByStatusId(3, context));

  }

  void onEditClicked(BuildContext context) async{
    
    List<Widget> bookStatusesToShow = new List.from(bookStatuses);
    
    bookStatusesToShow.removeAt(model.bookStatus - 1);
    
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                BoldText(Strings.selectNewStatus),
                SizedBox(height: 10,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookStatusesToShow.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5,),
                        bookStatusesToShow[index],
                        SizedBox(height: 5,),
                      ],
                    );
                  }
                ),
                SizedBox(height: 20,)
              ],
            ),
          );
        }
    );

  }

  void onDeleteClicked(BuildContext context) async {

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                BoldText(Strings.doYouReallyWantToDelete),
                SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlineAppButton(
                      text: Strings.no,
                      small: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 10,),
                    AppButton(
                      text: Strings.yes,
                      small: true,
                      onPressed: () => deleteBook(context),
                    )
                  ],
                ),
                SizedBox(height: 25,)
              ],
            ),
          );
        }
    );
    
  }

  void contactUser() {

    Mailto mailtoLink = Mailto(
        to: [model.email],
        subject: "ExchangeBooks: info sul libro '" + model.title + "'"
    );

    launch('$mailtoLink');
  }

  Widget _createWidgetByStatusId (int status, BuildContext context){

    Color color = Colors.green;
    String availability = Strings.available;

    if(status == 2){

      color = Colors.orange;
      availability = Strings.inTalks;

    }else if(status == 3){

      color = Colors.red;
      availability = Strings.notAvaliable;

    }

    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () => setBookStatus(status, context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.circle, color: color, size: 12,),
            SizedBox(width: 4,),
            RegularText(availability)
          ],
        ),
      ),
    );
  }

  void setBookStatus(int status, BuildContext context) async{
    Navigator.of(context).pop();

    DataManager dm = DataManager();

    this.showProgress();

    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      return;
    }

    var dmr = await dm.managerBook.updateBookStatus(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response,
        id: model.id,
        status: status
    );

    this.dismissProgress();

    if(dmr.hasError()){
      showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorMessage, AlertType.error);
      return;
    }

    Routes.sailor.pop(true);

  }

  void deleteBook(BuildContext context) async {
    Navigator.of(context).pop();

    DataManager dm = DataManager();

    this.showProgress();

    var dmrToken = await dm.managerUser.getBearerToken();

    if(dmrToken.hasError()){
      this.dismissProgress();
      return;
    }

    var dmr = await dm.managerBook.deleteBook(
        AppConfig.of(context).apiHostUrl,
        dmrToken.response,
        id: model.id
    );

    this.dismissProgress();

    if(dmr.hasError()){
      showAlert(Strings.genericHttpErrorTitle, Strings.genericHttpErrorMessage, AlertType.error);
      return;
    }

    Routes.sailor.pop(true);
  }

}