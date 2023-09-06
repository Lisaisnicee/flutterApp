import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final MyUser user;
  const ViewProfile({super.key, required this.user});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    List<String> favorites = moi.favorites;

    bool isFavorite = favorites.contains(user.email);
    return Stack(
      children: <Widget>[
        Container(
          height: 300,
          width: 250,
          padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 73, 73, 73),
                    offset: Offset(0, 3),
                    blurRadius: 50),
              ]),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 65.0,
                  top: 20,
                  bottom: 20,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.avatar!),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 95),
                    Text(
                      user.fullName,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    (isFavorite)
                        ? Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      moi.removeFromFavorites(user.email);
                                    } else {
                                      print("clicked");
                                      moi.addToFavorites(user.email);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.heart_broken,
                                      color: const Color.fromARGB(
                                          255, 255, 158, 191)),
                                )),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      moi.removeFromFavorites(user.email);
                                    } else {
                                      print("clicked");
                                      moi.addToFavorites(user.email);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.favorite,
                                      color: const Color.fromARGB(
                                          255, 255, 158, 191)),
                                )),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
