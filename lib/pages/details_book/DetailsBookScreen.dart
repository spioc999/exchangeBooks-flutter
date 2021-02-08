import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/helpers/DateHelper.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/pages/details_book/DetailsBookViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/AppHeader.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/AppIconButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsBookScreen extends StatefulWidget {
  @override
  _DetailsBookScreenState createState() => _DetailsBookScreenState();
}

class _DetailsBookScreenState extends State<DetailsBookScreen> with WidgetsBindingObserver{

  DetailsBookViewModel viewModel;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    viewModel = Provider.of<DetailsBookViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      color: Colors.white,
      safeAreaTop: true,
      safeAreaBottom: true,
      header: AppHeader(),
      body: SafeAreaScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20, width: double.infinity,),
              BoldText(viewModel.model.title, fontSize: 25, maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              BoldText(Strings.isbn.toUpperCase() + ": " + viewModel.model.isbn, fontSize: 20, color: AppColors.appBlue,),
              SizedBox(height: 30,),
              Row(
                children: [
                  Card(
                    child: ImageHelper.getNetworkImage(viewModel.model.imageLink, height: 225),
                    elevation: 3.5,
                    shadowColor: AppColors.appBlue,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Card(
                      elevation: 3.5,
                      shadowColor: AppColors.appBlue,
                      child: Container(
                        height: 225,
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegularText(Strings.authors + ":", fontSize: 12,),
                            BoldText(viewModel.model.authors, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 12,),
                            RegularText(Strings.publishedYear + ":", fontSize: 12,),
                            BoldText(DateHelper.getPublishedYear(viewModel.model.publishedDate)),
                            SizedBox(height: 12,),
                            RegularText(Strings.status + ":", fontSize: 12,),
                            _createAvaliabilityIndicator(),
                            SizedBox(height: 12,),
                            RegularText(viewModel.model.isOwned ? (Strings.yourNotes + ":") : (Strings.notes + " @" + viewModel.model.username + ":"), fontSize: 12,),
                            BoldText(viewModel.model.note, maxLines: 3, autoResize: true,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: !viewModel.model.isOwned,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    BoldText(Strings.owner, fontSize: 20, color: AppColors.appBlue,),
                    SizedBox(height: 5, width: double.infinity,),
                    Card(
                      elevation: 3.5,
                      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      shadowColor: AppColors.appBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Center(
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      color: AppColors.appBlue,
                                    ),
                                  )
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container()
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RegularText(Strings.nameAndSurname + ":", fontSize: 12,),
                                      BoldText(viewModel.model.firstName + " " + viewModel.model.lastName, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      SizedBox(height: 14,),
                                      RegularText(Strings.username + ":", fontSize: 12,),
                                      BoldText("@" + viewModel.model.username, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      SizedBox(height: 14,),
                                      RegularText(Strings.whereLives + ":", fontSize: 12,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined, color: AppColors.appBlue, size: 17,),
                                          BoldText(viewModel.model.city, maxLines: 1, overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                      SizedBox(height: 14,),
                                      RegularText(Strings.whenInserted + ":", fontSize: 12,),
                                      BoldText(DateHelper.getInsertionDateFormatted(viewModel.model.dateInsertion), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            AppIconButton(
                              key: ValueKey(ExchangeBooksValueKey.contactButtonDetails),
                              text: Strings.contact + " " + viewModel.model.firstName,
                              icon: Icons.email_outlined,
                              small: true,
                              smallWidth: 250,
                              onPressed: () => viewModel.contactUser(),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Visibility(
                visible: viewModel.model.isOwned,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 17, width: double.infinity,),
                    RegularText(Strings.whenYouInserted + ":", fontSize: 12,),
                    BoldText(DateHelper.getInsertionDateFormatted(viewModel.model.dateInsertion), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 40,),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: AppIconButton(
                            key: ValueKey(ExchangeBooksValueKey.editButtonDetails),
                            text: Strings.editStatus,
                            icon: Icons.edit_outlined,
                            onPressed: () => viewModel.onEditClicked(context),
                          )),
                        Flexible(
                          flex: 1,
                          child: Container()),
                        Expanded(
                          flex: 10,
                          child: AppIconButton(
                            key: ValueKey(ExchangeBooksValueKey.deleteButtonDetails),
                            text: Strings.deleteInsertion,
                            icon: Icons.delete_outline,
                            onPressed: () => viewModel.onDeleteClicked(context),
                          )),
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAvaliabilityIndicator (){

    Color color = Colors.green;
    String availability = Strings.available;

    if(viewModel.model.bookStatus == 2){

      color = Colors.orange;
      availability = Strings.inTalks;

    }else if(viewModel.model.bookStatus == 3){

      color = Colors.red;
      availability = Strings.notAvaliable;

    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 12,),
        SizedBox(width: 4,),
        BoldText(availability)
      ],
    );
  }
}
