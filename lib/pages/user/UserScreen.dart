import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/pages/user/UserViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/AppHeader.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/OutlineAppHeaderIconButton.dart';
import 'package:exchange_books/widgets/list_items/MyBookListItem.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with WidgetsBindingObserver{

  UserViewModel viewModel;

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

    viewModel = Provider.of<UserViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      safeAreaBottom: true,
      safeAreaTop: true,
      color: Colors.white,
      header: AppHeader(
        rightWidget: OutlineAppHeaderIconButton(
          key: ValueKey(ExchangeBooksValueKey.logoutUser),
          text: Strings.logout,
          iconData: Icons.login_outlined,
          small: true,
          onPressed: () => viewModel.onPressLogout(),
        ),
      ),
      body: SafeAreaScrollView(
        shouldSroll: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20, width: double.infinity,),
              _getWelcomeText(),
              SizedBox(height: 20,),
              BoldText(Strings.yourData, color: AppColors.appBlue, fontSize: 20,),
              SizedBox(height: 5,),
              _getDataCard(),
              SizedBox(height: 30,),
              _getMyBooksTitle(),
              SizedBox(height: 5,),
              Expanded(
                child: SingleChildScrollView(
                    child: _buildBooksList(context))
                /*child: RefreshIndicator(
                  color: AppColors.appBlue,
                  onRefresh: () => viewModel.init(context),
                  child: SingleChildScrollView(
                      child: _buildBooksList()),
                ),*/
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getWelcomeText(){

    if(viewModel.user == null)
      return Container();

    return BoldText(Strings.hi + viewModel.user.firstName + "!", fontSize: 25,);
  }

  Widget _getDataCard(){

    if(viewModel.user == null)
      return Container();

    return Card(
      elevation: 3.5,
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      shadowColor: AppColors.appBlue,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegularText(Strings.nameAndSurname + ":", fontSize: 12,),
                  BoldText(viewModel.user.firstName + " " + viewModel.user.lastName, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 14,),
                  RegularText(Strings.username + ":", fontSize: 12,),
                  BoldText("@" + viewModel.user.username, maxLines: 1, overflow: TextOverflow.ellipsis,),
                ],
              )
            ),
            Flexible(
              flex: 1,
              child: Container()),
            Expanded(
                flex: 13,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularText(Strings.email + ":", fontSize: 12,),
                    BoldText(viewModel.user.email, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 14,),
                    RegularText(Strings.whereYouLive + ":", fontSize: 12,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, color: AppColors.appBlue, size: 17,),
                        BoldText(viewModel.user.city + " (" + viewModel.user.province + ")" , maxLines: 1, overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMyBooksTitle(){

    String title;

    if(viewModel.myBooks == null){
      title = "";
    }else if(viewModel.myBooks.isEmpty){
      title = Strings.noBooksYet;
    }else{
      title = Strings.yourBooks;
    }

    return BoldText(title, color: AppColors.appBlue, fontSize: 20,);
  }

  Widget _buildBooksList(BuildContext context) {
    if(viewModel.myBooks != null && viewModel.myBooks.isNotEmpty){
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.myBooks.length,
        itemBuilder: (context, index){
          MyBookListItemModel model = MyBookListItemModel(
              imageLink: viewModel.myBooks[index].thumbnailLink,
              bookName: viewModel.myBooks[index].title,
              bookStatus: viewModel.myBooks[index].bookStatus,
              isbn: viewModel.myBooks[index].isbn,
              insertionDate: viewModel.myBooks[index].dateInsertion
          );

          return MyBookListItem(model, () => viewModel.onClickBook(index, context), key: ValueKey(ExchangeBooksValueKey.bookItemUser + "_$index"),);

        },);
    }else{
      return Container();
    }
  }
}
