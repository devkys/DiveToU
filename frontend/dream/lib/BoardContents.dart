class BoardContents{
  int id;
  String contents;
  String writer;
  String? dateTime;

  BoardContents({required this.id, required this.contents, required this.writer, this.dateTime});

  factory BoardContents.fromJson(Map<String, dynamic> addjson){
    return BoardContents(
      id: addjson["id"],
      contents:  addjson["contents"],
      writer: addjson["writer"],
      dateTime: addjson["time"]
    );
  }
  
}