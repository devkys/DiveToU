
class Team {

  final String team_name;
  final String r_image;
  Team({required this.team_name, required this.r_image});
  // late List<Team> list;


  factory Team.fromJson(Map<String, dynamic> json) {


    // List list = [];
    // List<Team> jsonlist = <Team>[];
    // for (var i = 0; i < json.length; i++) {
    //   print(json[i]);
    //   list.add(json);
    // }
    // List<Team> jsonlist = <Team>[];
    // print("team :  + ${json}");
    return switch(json) {
      {
        'singer': String team_name2,
        'image_path': String r_image2
       } =>
        Team(
          team_name: team_name2,
          r_image: r_image2
        ),
        _ => throw FormatException('Failed to load Team')

    };
  //   list.add(json);

    // return Team(
    //   team_name: json['singer'],
    //   r_image: json['image_path']
    // );
    // return jsonlist;
  }

}