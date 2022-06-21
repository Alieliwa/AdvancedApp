import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/constant_manager.dart';
import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/resources/valuse_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1,
            ImageAssets.OnBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2,
            ImageAssets.OnBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3,
            ImageAssets.OnBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4,
            ImageAssets.OnBoardingLogo4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.SkipOnBoarding,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left Arrow Icon
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: (){
              //go to previous slide
              _pageController.animateToPage(_getPreviousIndex(),
                  duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.arrowleft),
            ),
          ),

          ),

          //Circle Indicator
          Row(
            children: [
              for(int i = 0; i < _list.length; i++)
                Padding(padding: EdgeInsets.all(AppPadding.p8,),
                child: _getProperCircle(i),
                )
            ],
          ),
          //Right Arrow Icon
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: (){
                //go to previous slide
                _pageController.animateToPage(_getNextIndex(),
                    duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.arrowright),
              ),
            ),

          ),
        ],
      ),
    );
  }
  int _getPreviousIndex(){
    int previousindex = -- _currentIndex ;
    if(previousindex == -1) {
      previousindex == _list.length -1;
    }
    return previousindex;
  }
  int _getNextIndex(){
    int Nextindex = ++ _currentIndex;
    if(Nextindex == _list.length) {
      Nextindex == 0;
    }
    return Nextindex;
  }

  Widget _getProperCircle(int index){
    if(index == _currentIndex){
      return  SvgPicture.asset(ImageAssets.hollowCircle);
    } else
      return SvgPicture.asset(ImageAssets.solideCircle);
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            "${_sliderObject.title}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            "${_sliderObject.subTitle}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset("${_sliderObject.image}"),
      ],
    );
  }
}

class SliderObject {
  String? title;
  String? subTitle;
  String? image;

  SliderObject(this.title, this.subTitle, this.image);
}
