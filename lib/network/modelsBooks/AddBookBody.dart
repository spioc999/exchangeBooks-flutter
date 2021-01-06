class AddBookBody {
  int idBook;
  String note;

  AddBookBody({this.idBook, this.note});

  AddBookBody.fromJson(Map<String, dynamic> json) {
    idBook = json['idBook'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBook'] = this.idBook;
    data['note'] = this.note;
    return data;
  }
}