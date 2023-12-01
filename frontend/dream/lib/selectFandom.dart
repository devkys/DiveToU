import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectFandom extends StatefulWidget {
  const SelectFandom({super.key});

  @override
  State<SelectFandom> createState() => _SelectFandomState();
}

class _SelectFandomState extends State<SelectFandom>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.bottomLeft,
    end: Alignment.center,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // search field controller
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  Future singer(String singer) async {
    final singerSearch_uri =
        Uri.http('localhost:3000', '/search/artists', {'team': singer});

    try {
      var res = await http.get(
        singerSearch_uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: fieldText,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'enter',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          onPressed: () {
                            clearText();
                          })),
                  onFieldSubmitted: (value) {
                    singer(value);
                    print(value);
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
              Container(
                height: 650,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.all(150),
                    child: AlignTransition(
                        alignment: _animation,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/riize.jpeg'),
                              radius: 40,
                            ),
                            Text('riize')
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
