class DetailsBookScreenModel {
  bool isOwned;
  String imageLink;
  String title;
  String authors;
  String publishedDate;
  String city;
  int bookStatus;
  String isbn;
  String note;
  DateTime dateInsertion;
  String username;
  String email;
  String lastName;
  String firstName;
  int id;

  DetailsBookScreenModel({
      this.isOwned,
      this.imageLink,
      this.authors,
      this.publishedDate,
      this.city,
      this.bookStatus,
      this.title,
      this.isbn,
      this.note,
      this.dateInsertion,
      this.username,
      this.email,
      this.lastName,
      this.firstName,
      this.id = 0
  });
}