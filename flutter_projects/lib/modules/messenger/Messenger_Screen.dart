import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1383494314487992329/cMFfONbx_200x200.jpg'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
                'Chats',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: ()
          {
            print('Camera Butoon is Clicked');
          },
              icon: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.black.withOpacity(.3),
                child: Icon(
                  Icons.camera_alt,
                ),
              )),
          IconButton(onPressed: ()
          {
            print('Edit Butoon is Clicked');
          },
              icon: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.black.withOpacity(.3),
                child: Icon(
                  Icons.edit,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // search Bar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[350],
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Search')
                  ],
                ),

              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index)
                    {
                      return buildStoriesItem();
                    } ,
                  separatorBuilder: (context ,index)
                  {
                    return SizedBox(
                      width: 20,
                    );
                  },
                  itemCount: 20,
                ),
              ),
               ListView.separated(
                 physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context , index)
                    {
                      return buildChatItem();
                    },
                    separatorBuilder: (context , index)
                    {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: 10),
            ],
          ),
        ),
      ),
    );
  }

  // to build the list
Widget buildChatItem()=>Row(
  children:
  [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 35.0,
          backgroundImage: NetworkImage('https://publish.one37pm.net/wp-content/uploads/2021/12/SuperMarioRunTA.jpeg?fit=680%2C510'),
        ),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          radius: 9.0,
          backgroundColor: Colors.green,
        ),
      ],
    ),
    SizedBox(
      width: 20.0,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Arthur Morgan',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'the message is from Philo Maged,hi are you there',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text('03.38 AM')
            ],
          ),
        ],
      ),
    ),
  ],
);
Widget buildStoriesItem() => Container(
  width: 80.0,
  child: Column(
  children: [
  Stack(
  alignment: AlignmentDirectional.bottomEnd,
  children: [
  CircleAvatar(
  radius: 40.0,
  backgroundImage: NetworkImage('https://publish.one37pm.net/wp-content/uploads/2021/12/SuperMarioRunTA.jpeg?fit=680%2C510'),
  ),
  CircleAvatar(
  radius: 10.0,
  backgroundColor: Colors.white,
  ),
  CircleAvatar(
  radius: 9.0,
  backgroundColor: Colors.green,
  ),
  ],
  ),
  SizedBox(
  height: 6.0,
  ),
  Text(
  'Super Mario',
  style: TextStyle(
  ),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  ),
  ],
  ),
  );

}