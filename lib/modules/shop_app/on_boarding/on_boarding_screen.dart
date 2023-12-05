import 'package:flutter/material.dart';
import 'package:my_first_app/modules/shop_app/login/login_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../styles/colors.dart';
class OnBoarding
{
  late final String image;
  late final String title;
  late final String body;

  OnBoarding(this.image, this.title, this.body);
}


class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<OnBoarding> onBoarding =
  [
    OnBoarding(
  "assets/images/on_boardning_one.png",
  "OnBoard 1 Title",
  "OnBoard 1 body"
  ),
    OnBoarding(
        "assets/images/on_boardning_one.png",
        "OnBoard 2 Title",
        "OnBoard 2 body"
    ),
    OnBoarding(
        "assets/images/on_boardning_one.png",
        "OnBoard 3 Title",
        "OnBoard 3 body"
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
                submit(context);
                },
              child: Text("SKIP"),
          )
        ],
        //backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index == onBoarding.length - 1)
                    {
                      isLast = true;
                      setState(() {});
                    }
                  else
                  {
                    isLast = false;
                    setState(() {});
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context ,index)=> buildOnBoardingItem(onBoarding[index]),
                itemCount: onBoarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: onBoarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton.small(
                    onPressed: ()
                    {
                      submit(context);
                      if(isLast)
                        {
                          navigateTo(context, ShopLoginScreen());
                        }else{
                        boardingController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ), curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(OnBoarding model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Image(
        image: AssetImage(model.image),
        height: 400,
        width: 400,
    ),
    SizedBox(
      height: 50.0,
    ),
    Text(
      model.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
          fontFamily: "jannah",
        fontSize: 30,
      ),
    ),
    SizedBox(
      height: 20.0,
    ),
    Text(
      model.body,
      style: TextStyle(
          fontFamily: "jannah",
        fontWeight: FontWeight.bold,
          fontSize: 20,
      ),
    ),
  ],
);