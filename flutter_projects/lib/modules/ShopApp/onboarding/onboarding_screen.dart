import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/ShopApp/shop_login/login_screen.dart';
//import 'package:news_app/modules/shop_login/login_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}


class onBoardingScreen extends StatefulWidget
{
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> l = [
    BoardingModel(
        image: 'assets/images/onBoard1.jpg',
        title: 'OnBoardScreenTitle1',
        body: 'OnBoardScreenBody1'),
    BoardingModel(
        image: 'assets/images/onBoard1.jpg',
        title: 'OnBoardScreenTitle2',
        body: 'OnBoardScreenBody2'),
    BoardingModel(
        image: 'assets/images/onBoard1.jpg',
        title: 'OnBoardScreenTitle3',
        body: 'OnBoardScreenBody3'),
  ];
  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        navigateToandKill(context, LoginScreen());
      }
    });
    navigateToandKill(context, LoginScreen());
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP',style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildBoardingItem(l[index]),
                onPageChanged: (int index)
                {
                  if(index == l.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else
                  {
                    isLast = false;
                  }
                },
                itemCount: l.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: l.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.blue,
                  dotWidth: 10,
                  expansionFactor: 4,
                  dotHeight: 10,
                  spacing: 5,
                ),),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                    foregroundColor:Colors.white,
                    onPressed: ()
                    {
                      if(isLast)
                      {
                        submit();
                      }
                      else
                      {
                        pageController.nextPage(
                            duration: Duration(
                              milliseconds: 450,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                child: Icon(Icons.arrow_forward_ios),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////
  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(height: 10,),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jannah'
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jannah',
        ),
      ),
      SizedBox(height: 100,)
    ],
  );
}