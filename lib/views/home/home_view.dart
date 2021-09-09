import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/viewmodels/weather_vm.dart';
import 'package:mms_app/views/home/location_details_view.dart';
import 'package:mms_app/views/home/search_view.dart';
import 'package:mms_app/views/widgets/base_view.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';

import 'notification_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key, this.location}) : super(key: key);
  final String location;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherViewModel>(
        onModelReady: (WeatherViewModel model) async {
      if (widget.location == null) {
        Position val = await Geolocator.getCurrentPosition();
        await model.getCurrentData(val.latitude, val.longitude, null);
      } else {
        await model.getCurrentData(null, null, widget.location);
      }
    }, builder: (_, WeatherViewModel model, __) {
      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 100), () {});
          if (widget.location == null) {
            Position val = await Geolocator.getCurrentPosition();
            await model.getCurrentData(val.latitude, val.longitude, null);
          } else {
            await model.getCurrentData(null, null, widget.location);
          }
        },
        color: AppColors.white,
        backgroundColor: Colors.black,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff47BFDF),
                  Color(0xff4A91FF),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(25.h),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth / 2,
                          child: InkWell(
                            onTap: () {
                              routeTo(context, SearchView());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/loc.png',
                                  width: 18.h,
                                  height: 18.h,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: regularText(
                                        model.location ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.white,
                                        textAlign: TextAlign.center,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18.h,
                                  color: AppColors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25.h),
                                        topLeft: Radius.circular(25.h))),
                                builder: (context) {
                                  return NotificationView();
                                });
                          },
                          child: Image.asset(
                            'assets/images/notification.png',
                            width: 17.h,
                            height: 17.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: model.busy
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(.1),
                              highlightColor: Colors.white60,
                              child: Container(
                                width: 250.h,
                                height: 250.h,
                                color: AppColors.textGrey,
                              ))
                          : Image.network(
                              model?.currentWeather?.current?.weatherIcons
                                      ?.first ??
                                  '',
                              width: 250.h,
                              height: 250.h,
                              fit: BoxFit.fill,

                              /*      placeholder: (_, __) {
                                return Image.asset(
                                  'assets/images/sunny.png',
                                  width: 300.h,
                                  height: 300.h,
                                );
                              },
                              errorWidget: (_, ___, __) {
                                return Image.asset(
                                  'assets/images/sunny.png',
                                  width: 300.h,
                                  height: 300.h,
                                );
                              },*/
                            ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        routeTo(
                            context, LocationDetailsView(name: model.location));
                      },
                      child: Container(
                        padding: EdgeInsets.all(25.h),
                        decoration: BoxDecoration(
                            color: Color(0xff47BBE1),
                            borderRadius: BorderRadius.circular(25.h)),
                        child: Column(
                          children: [
                            regularText(
                              'Today, ${DateFormat('MMMM dd').format(DateTime.now())}',
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            regularText(
                              '${model?.currentWeather?.current?.temperature ?? ''}°C',
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 80.sp,
                            ),
                            regularText(
                              model?.currentWeather?.current
                                      ?.weatherDescriptions?.first ??
                                  '',
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 16.h),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/windy.png',
                                    width: 16.h,
                                    height: 16.h,
                                  ),
                                  SizedBox(width: 16.h),
                                  Flexible(
                                    flex: 1,
                                    child: regularText(
                                      'Wind',
                                      color: AppColors.white,
                                      textAlign: TextAlign.center,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.h, vertical: 4.h),
                                    child: VerticalDivider(
                                      color: AppColors.white,
                                      thickness: 1.h,
                                      width: 0,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: regularText(
                                      '${model?.currentWeather?.current?.windSpeed ?? ''}km/h',
                                      color: AppColors.white,
                                      textAlign: TextAlign.center,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/hum.png',
                                    width: 16.h,
                                    height: 16.h,
                                  ),
                                  SizedBox(width: 16.h),
                                  Flexible(
                                    flex: 1,
                                    child: regularText(
                                      'Hum',
                                      color: AppColors.white,
                                      textAlign: TextAlign.center,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.h, vertical: 4.h),
                                    child: VerticalDivider(
                                      color: AppColors.white,
                                      thickness: 1.h,
                                      width: 0,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: regularText(
                                      '${model?.currentWeather?.current?.humidity ?? ''}%',
                                      color: AppColors.white,
                                      textAlign: TextAlign.center,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
