import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/weather_vm.dart';
import 'package:mms_app/views/widgets/base_view.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class LocationDetailsView extends StatefulWidget {
  const LocationDetailsView({Key key, this.prediction}) : super(key: key);
  final Prediction prediction;

  @override
  _LocationDetailsViewState createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherViewModel>(
        onModelReady: (WeatherViewModel model) async {
      model.getHistoryData(widget.prediction.description);
    }, builder: (_, WeatherViewModel model, __) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.secdColor,
                Color(0xff4A91FF),
              ],
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16.h),
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 20.h,
                            color: AppColors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.h),
                            child: regularText(
                              'Back',
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/settings.png',
                        width: 30.h,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    regularText(
                      'Today',
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    Spacer(),
                    regularText(
                      'Sep, 12',
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 150.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 100,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? AppColors.secdColor.withOpacity(.5)
                                    : null,
                                borderRadius: BorderRadius.circular(12.h),
                                border: Border.all(
                                    width: 1.h,
                                    color: AppColors.white.withOpacity(.2))),
                            margin: EdgeInsets.only(
                                right: 10.h, top: 10.h, bottom: 10.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                regularText(
                                  '29°C',
                                  color: AppColors.white,
                                  textAlign: TextAlign.center,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                                SizedBox(height: 8.h),
                                Image.asset(
                                  'assets/images/sunny.png',
                                  height: 35.h,
                                  width: 35.h,
                                ),
                                regularText(
                                  '16.00',
                                  color: AppColors.white,
                                  textAlign: TextAlign.center,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    regularText(
                      'Next Forecast',
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/images/calendar.png',
                      height: 22.h,
                      width: 22.h,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            regularText('Sep, 13',
                                color: AppColors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(width: 10.h),
                            Expanded(
                              child: Image.asset(
                                'assets/images/sunny.png',
                                height: 30.h,
                                width: 30.h,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            regularText('21°',
                                color: AppColors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
