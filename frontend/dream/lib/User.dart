class User { 
  final String email;
  final String name;
  final String img_url;
  final int secret;

  User({required this.email, required this.name, required this.img_url, required this.secret});

  Map<String, dynamic> toJson(){
    return {
      'email' : email,
      'name' : name,
      'img_url' : img_url,
      'secret' : secret
    };
  }
    
}