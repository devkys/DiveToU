
class Team {

  final String team_name;
  final String r_image;
  Team({required this.team_name, required this.r_image});

  factory Team.fromJson(Map<String, dynamic> json) {

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
  }

}