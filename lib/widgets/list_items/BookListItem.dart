import 'package:exchange_books/helpers/DateHelper.dart';
import 'package:exchange_books/helpers/ImageHelper.dart';
import 'package:exchange_books/values/AppColors.dart';
import 'package:exchange_books/values/Strings.dart';
import 'package:exchange_books/widgets/text/BoldText.dart';
import 'package:exchange_books/widgets/text/RegularText.dart';
import 'package:flutter/material.dart';

class BookListItemModel {
  String imageLink;
  String bookName;
  String authors;
  String publishedDate;
  String city;
  int bookStatus;
  String isbn;

  BookListItemModel({this.imageLink, this.bookName, this.authors,
      this.publishedDate, this.city, this.bookStatus, this.isbn});
}

class BookListItem extends StatelessWidget {

  final BookListItemModel _model;
  final VoidCallback _onClick;


  BookListItem(this._model, this._onClick, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shadowColor: AppColors.appBlue.withOpacity(0.6),
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: _onClick,
          leading: ImageHelper.getNetworkImage(_model.imageLink, height: 60),
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(_model.bookName, maxLines: 2, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              BoldText(Strings.isbn.toUpperCase() + ": " + _model.isbn, fontSize: 13, color: AppColors.appBlue,),
              SizedBox(height: 5,),
              RegularText(_model.authors + " - " + DateHelper.getPublishedYear(_model.publishedDate), maxLines: 1, overflow: TextOverflow.ellipsis, fontSize: 10,)
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _createAvaliabilityIndicator(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.appBlue, size: 13,),
                  RegularText(_model.city, fontSize: 13,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAvaliabilityIndicator (){

    Color color = Colors.green;
    String availability = Strings.available;

    if(_model.bookStatus == 2){

      color = Colors.orange;
      availability = Strings.inTalks;

    }else if(_model.bookStatus == 3){

      color = Colors.red;
      availability = Strings.notAvaliable;

    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 10,),
        SizedBox(width: 2,),
        RegularText(availability, fontSize: 13,)
      ],
    );
  }
}
