import 'package:exchange_books/AppConfig.dart';
import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/pages/home/HomeViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/AppStyles.dart';
import 'package:exchange_books/values/ExchangeBooksValueKey.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/AppHeader.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/OutlineAppHeaderIconButton.dart';
import 'package:exchange_books/widgets/list_items/BookListItem.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{

  HomeViewModel viewModel;

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

    viewModel = Provider.of<HomeViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
      safeAreaTop: true,
      safeAreaBottom: true,
      floatingActionButton: FloatingActionButton(
        key: ValueKey(ExchangeBooksValueKey.addButtonHome),
        backgroundColor: AppColors.appBlue,
        onPressed: () {
          viewModel.onPressAdd();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      header: AppHeader(
        isHomePage: true,
        onLeftIconPressed: () async{

          await viewModel.getVersion();

          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  key: ValueKey(ExchangeBooksValueKey.infoBottomSheetHome),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageHelper.getPng("logo_blank", height: 50),
                          SizedBox(width: 5,),
                          BoldText(AppConfig.of(context).appName, fontSize: 27,),
                        ],
                      ),
                      RegularText("v" + (viewModel.version ?? "")),
                      SizedBox(height: 15,),
                      RegularText(Strings.createdBy),
                      SizedBox(height: 35,)
                    ],
                  ),
                );
              }
          );
        },
        rightWidget: OutlineAppHeaderIconButton(
          key: ValueKey(ExchangeBooksValueKey.userButtonHome),
          text: viewModel.name ?? '',
          small: true,
          onPressed: () => viewModel.onPressUser(),
        ),
      ),
      body: SafeAreaScrollView(
        shouldSroll: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20, width: double.infinity,),
              BoldText(Strings.booksInNearby, fontSize: 25,),
              SizedBox(height: 3,),
              RegularText(Strings.province + " " + (viewModel.province ?? ""), fontSize: 15,),
              SizedBox(height: 20,),
              TextFormField(
                key: ValueKey(ExchangeBooksValueKey.searchHome),
                autocorrect: false,
                controller: viewModel.searchController,
                style: AppStyles.blackTextStyle,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_sharp, color: AppColors.appBlue,),
                    focusColor: AppColors.appBlue,
                    contentPadding: EdgeInsets.symmetric(vertical: -1),
                    hintText: Strings.search,
                    hintStyle: AppStyles.greyTextStyle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                ),
                onChanged: (newValue) {
                  viewModel.onChangeFilter(newValue);
                },
              ),
              SizedBox(height: 10,),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.appBlue,
                  onRefresh: () => viewModel.init(context, shoulShowProgress: false),
                  child: _buildBooksList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBooksList() {
    if(viewModel.filteredBooks != null && viewModel.filteredBooks.isNotEmpty){
      return ListView.builder(
          key: ValueKey(ExchangeBooksValueKey.bookListHome),
          physics: AlwaysScrollableScrollPhysics(),
          //shrinkWrap: true,
          itemCount: viewModel.filteredBooks.length,
          itemBuilder: (context, index){
            BookListItemModel model = BookListItemModel(
              imageLink: viewModel.filteredBooks[index].thumbnailLink,
              bookName: viewModel.filteredBooks[index].title,
              authors: viewModel.filteredBooks[index].authors,
              publishedDate: viewModel.filteredBooks[index].publishedDate,
              city: viewModel.filteredBooks[index].city,
              bookStatus: viewModel.filteredBooks[index].bookStatus,
              isbn: viewModel.filteredBooks[index].isbn
            );

            return BookListItem(model, () => viewModel.onClickBook(index), key: ValueKey(ExchangeBooksValueKey.bookHome + "_$index"),);

          },);
    }else{
      return Center(child: RegularText(Strings.noResults));
    }
  }
}
