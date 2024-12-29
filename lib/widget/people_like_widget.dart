import 'package:esgix_project/widget/user_widget.dart';
import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class PeopleLikeWidget extends StatelessWidget {
  final List<User> peopleLikeList;

  const PeopleLikeWidget({required this.peopleLikeList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peopleLikeList.length,
        itemBuilder: (context, index) {
          return UserWidget(user: peopleLikeList[index]);
        },
      ),
    );
  }
}