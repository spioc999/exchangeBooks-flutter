class SearchBooksResult {
  String username;
  String email;
  String lastName;
  String firstName;
  String city;
  String isbn;
  String title;
  String authors;
  String publishedDate;
  String thumbnailLink;
  int bookStatus;
  String note;
  DateTime dateInsertion;

  SearchBooksResult(
      {this.username,
        this.email,
        this.lastName,
        this.firstName,
        this.city,
        this.isbn,
        this.title,
        this.authors,
        this.publishedDate,
        this.thumbnailLink,
        this.bookStatus,
        this.note,
        this.dateInsertion});

  SearchBooksResult.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    city = json['city'];
    isbn = json['isbn'];
    title = json['title'];
    authors = json['authors'];
    publishedDate = json['publishedDate'];
    thumbnailLink = json['thumbnailLink'];
    bookStatus = json['bookStatus'];
    note = json['note'];
    dateInsertion = json['dateInsertion'] != null ? DateTime.parse(json['dateInsertion']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['city'] = this.city;
    data['isbn'] = this.isbn;
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['publishedDate'] = this.publishedDate;
    data['thumbnailLink'] = this.thumbnailLink;
    data['bookStatus'] = this.bookStatus;
    data['note'] = this.note;
    if(this.dateInsertion != null){
      data['dateInsertion'] = this.dateInsertion.toUtc().toIso8601String();
    }
    return data;
  }
}