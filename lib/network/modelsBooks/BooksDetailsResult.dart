class BooksDetailsResult{
  int id;
  String isbn;
  String title;
  String authors;
  String publishedDate;
  String thumbnailLink;

  BooksDetailsResult(
      {this.id,
        this.isbn,
        this.title,
        this.authors,
        this.publishedDate,
        this.thumbnailLink});

  BooksDetailsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isbn = json['isbn'];
    title = json['title'];
    authors = json['authors'];
    publishedDate = json['publishedDate'];
    thumbnailLink = json['thumbnailLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isbn'] = this.isbn;
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['publishedDate'] = this.publishedDate;
    data['thumbnailLink'] = this.thumbnailLink;
    return data;
  }
}