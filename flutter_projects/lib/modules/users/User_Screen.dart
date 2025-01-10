import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/user/user_model.dart';
class UserScreen extends StatelessWidget
{
  List<User> l = [
    User(id: 1, username: 'philopateer maged', phone: '0123243242332'),
    User(id: 2, phone: '3141414124', username: 'lionel messi'),
    User(id: 3, phone: '4141241241', username: 'Arthur Morgan'),
    User(id: 4, phone: '4364626262', username: 'Super Mario'),
    User(id: 1, username: 'Youhana maged', phone: '0123243242332'),
    User(id: 5, phone: '3141414124', username: 'lionel messi'),
    User(id: 6, phone: '4141241241', username: 'Arthur Morgan'),
    User(id: 7, phone: '4364626262', username: 'Super Mario'),
    User(id: 1, username: 'maged malak', phone: '0123243242332'),
    User(id: 2, phone: '3141414124', username: 'lionel messi'),
    User(id: 3, phone: '4141241241', username: 'Arthur Morgan'),
    User(id: 4, phone: '4364626262', username: 'Super Mario'),
    User(id: 1, username: 'Randa fares', phone: '0123243242332'),
    User(id: 5, phone: '3141414124', username: 'lionel messi'),
    User(id: 6, phone: '4141241241', username: 'Arthur Morgan'),
    User(id: 7, phone: '4364626262', username: 'Super Mario'),
  ];
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Users',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context,index)
            {
              return buildUserDate(l[index]);
            },
            separatorBuilder: (context , index)
            {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 0
                ),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              );
            },
            itemCount: l.length),
      ),
    );
  }

Widget buildUserDate(User u) =>Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CircleAvatar(
      radius: 30,
      backgroundColor: Colors.blue,
      child: Text(
        '${u.id}',
        style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
    SizedBox(
      width: 20,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${u.username}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        //SizedBox(height: 10,),
        Text(
          '${u.phone}',
          style: TextStyle(
              color: Colors.grey
          ),
        ),

      ],
    ),
  ],
);

}