import 'package:exchange_books/base/BaseWidget.dart';
import 'package:exchange_books/helpers/DateHelper.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/pages/add_book/AddBookViewModel.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/AppStyles.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/AppHeader.dart';
import 'package:exchange_books/widgets/SafeAreScrollView.dart';
import 'package:exchange_books/widgets/button/AppButton.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> with WidgetsBindingObserver{

  AddBookViewModel viewModel;

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

    viewModel = Provider.of<AddBookViewModel>(context);

    return BaseWidget(
      progress: viewModel.progress,
      alert: viewModel.alert,
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
              BoldText(Strings.addNewBook, fontSize: 25,),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    flex: 13,
                    child: TextFormField(
                      autocorrect: false,
                      controller: viewModel.isbnController,
                      style: AppStyles.blackTextStyle,
                      textInputAction: TextInputAction.done,
                      buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                      maxLength: 13,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        viewModel.checkIsbnLength();
                        viewModel.getInfoBook(context);
                      },
                      decoration: InputDecoration(
                          errorStyle: AppStyles.errorTextStyle,
                          errorText: viewModel.errorIsbn ? (viewModel.errorHttpIsbn ? Strings.errorHttpIsbnText : Strings.errorIsbnText) : null,
                          focusColor: AppColors.appBlue,
                          hintText: Strings.isbn.toUpperCase(),
                          hintStyle: AppStyles.greyTextStyle,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                      ),
                      onChanged: (newValue) {
                        viewModel.onChangeIsbn(newValue);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container()
                  ),
                  Flexible(
                    flex: 3,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusScopeNode());
                        viewModel.onClickScan(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageHelper.getSvg("barcode-scanner", height: 40, color: AppColors.appBlue),
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RegularText(Strings.suggestionIsbn, fontSize: 14,),
              ),
              SizedBox(height: 45,),
              Visibility(
                visible: viewModel.bookFound != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(Strings.infoAboutBook, fontSize: 20, color: AppColors.appBlue,),
                    SizedBox(height: 7,),
                    BoldText(Strings.isbn.toUpperCase() + ": " + (viewModel.isbn ?? ""), fontSize: 15,),
                    SizedBox(height: 20, width: double.infinity,),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: _getImage()),
                        Flexible(
                          flex: 1,
                          child: Container()),
                        Expanded(
                          flex: 10,
                          child: _createInfo()
                        )
                      ],
                    ),
                    SizedBox(height: 15, width: double.infinity,),
                    TextFormField(
                      autocorrect: false,
                      controller: viewModel.notesController,
                      style: AppStyles.blackTextStyle,
                      /*buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                      maxLength: 13,*/
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                          focusColor: AppColors.appBlue,
                          hintText: Strings.insertNotes,
                          hintStyle: AppStyles.greyTextStyle,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),)
                      ),
                      onChanged: (newValue) {
                        viewModel.onChangeNotes(newValue);
                      },
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(height: MediaQuery.of(context).size.height/12, width: double.infinity,),
                      onTap: () => FocusScope.of(context).requestFocus(new FocusScopeNode()),
                    ),
                    AppButton(
                      enabled: viewModel.isValidNote(),
                      text: Strings.add,
                      onPressed: (){
                        FocusScope.of(context).requestFocus(new FocusScopeNode());
                        viewModel.onClickAdd(context);
                      },
                    ),
                    SizedBox(height: 6,)
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImage(){

    if(viewModel.bookFound != null)
      return Card(
        child: Container(
          height: 155,
          child: ImageHelper.getNetworkImage(viewModel.bookFound.thumbnailLink)
        ),
        elevation: 3.5,
        shadowColor: AppColors.appBlue,
        margin: EdgeInsets.symmetric(horizontal: 1),
      );

    return Container();
  }

  Widget _createInfo() {

    if(viewModel.bookFound != null){
      return Card(
        elevation: 3.5,
        shadowColor: AppColors.appBlue,
        child: Container(
          height: 155,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(Strings.title + ":", fontSize: 12,),
                BoldText(viewModel.bookFound.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 15,),
                RegularText(Strings.authors + ":", fontSize: 12,),
                BoldText(viewModel.bookFound.authors, maxLines: 1, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 15,),
                RegularText(Strings.publishedYear + ":", fontSize: 12,),
                BoldText(DateHelper.getPublishedYear(viewModel.bookFound.publishedDate)),
              ],
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
