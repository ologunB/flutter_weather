import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * .9,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 11.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50.h,
                height: 2.h,
                decoration: BoxDecoration(
                    color: AppColors.textGrey,
                    borderRadius: BorderRadius.circular(2.h)),
              )
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            child: regularText(
              'Your notification',
              color: AppColors.lightBlack,
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            child: regularText(
              'New',
              color: AppColors.lightBlack,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.primaryColor.withOpacity(.2),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 5.h),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/star.png',
                        width: 14.h,
                        height: 14.h,
                      ),
                      SizedBox(width: 10.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              regularText(
                                '10 minutes ago',
                                color: AppColors.lightBlack,
                                fontSize: 12.sp,
                              ),
                              SizedBox(height: 4.h),
                              regularText(
                                  'A sunny day in your location, consider wearing your UV protection',
                                  color: AppColors.lightBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.lightBlack,
                        size: 20.h,
                      )
                    ],
                  ),
                );
              }),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            child: regularText(
              'Older',
              color: AppColors.lightBlack,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 5.h),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/star.png',
                        width: 14.h,
                        height: 14.h,
                      ),
                      SizedBox(width: 10.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              regularText(
                                '10 minutes ago',
                                color: AppColors.lightBlack,
                                fontSize: 12.sp,
                              ),
                              SizedBox(height: 4.h),
                              regularText(
                                  'A sunny day in your location, consider wearing your UV protection',
                                  color: AppColors.lightBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.lightBlack,
                        size: 20.h,
                      )
                    ],
                  ),
                );
              }),
          SizedBox(height: 50.h),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
