class GetBooksResult {
  int id;
  String isbn;
  String title;
  String authors;
  String publishedDate;
  String thumbnailLink;
  int bookStatus;
  String note;
  DateTime dateInsertion;

  GetBooksResult(
      {this.id,
        this.isbn,
        this.title,
        this.authors,
        this.publishedDate,
        this.thumbnailLink,
        this.bookStatus,
        this.note,
        this.dateInsertion});

  GetBooksResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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