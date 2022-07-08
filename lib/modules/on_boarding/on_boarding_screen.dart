import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';


class  BoardingModel{
 final String image;
 final String title;
 final String body;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body
  });

}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();
  bool isLast = false;

  List<BoardingModel> boardingList=[
    BoardingModel(
        image: "assets/images/img1.png",
        title: 'Fractional shares',
        body: 'Instead of having to buy an entire share, invest any amount you want.'
    ),
    BoardingModel(
        image: "assets/images/img1.png",
        title: 'Fractional shares',
        body: 'Instead of having to buy an entire share, invest any amount you want.'
    ),
    BoardingModel(
        image: "assets/images/img1.png",
        title: 'Fractional shares',
        body: 'Instead of having to buy an entire share, invest any amount you want.'
    ),
  ];

  void submitSkip(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context,LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submitSkip,
              text: 'skip'
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemBuilder: (context,index)=>buildBoardingItem(boardingList[index]),
                  physics: BouncingScrollPhysics(),
                  itemCount: boardingList.length,
                  controller: boardController,
                  onPageChanged: (index){
                    if(index == boardingList.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count:  boardingList.length,
                  axisDirection: Axis.horizontal,
                  effect:  ExpandingDotsEffect	(
                          spacing:  8.0,
                          radius:  10.0,
                          dotWidth:  14.0,
                          dotHeight:  12.0,
                          expansionFactor: 3,
                          dotColor:  Colors.grey,
                          activeDotColor:defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                    onPressed: (){
                      if(isLast){
                        submitSkip();
                      }else{
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeInCubic);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios,size: 19,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
   mainAxisAlignment: MainAxisAlignment.center,
   crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(height: 30,),
      Text('${model.title}',style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),),
      SizedBox(height: 15,),
      Text('${model.body}',
        style:TextStyle(fontSize: 19.0) ,textAlign: TextAlign.center,),
      SizedBox(height: 30,),
    ],
  );
}
