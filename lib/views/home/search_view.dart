import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/home/location_details_view.dart';
import 'package:mms_app/views/widgets/map_bounder.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import '../widgets/autocomplete_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = <Marker>{};

  Future<void> initMapStyle([GoogleMapController controller]) async {
    controller ??= await _controller?.future;
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, List<dynamic> barbers) async {
    _controller.complete(controller);
    await initMapStyle(controller);
    List<LatLng> latLngs = [];

    // _setBoundsOnMap(controller, latLngs);
  }

  Future<void> _setBoundsOnMap(
      GoogleMapController controller, List<LatLng> locs) async {
    // the bounds you want to set
    final LatLngBounds bounds = MapUtils.boundsFromLatLngList(locs);
    if (mounted)
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 30.h));
    setState(() {});
  }

  Future<void> onCameraIdle(List<dynamic> barbers) async {
    final GoogleMapController controller = await _controller.future;

    Future<void>.delayed(const Duration(milliseconds: 2000), () {
      List<LatLng> latLngs = [];

      //  _setBoundsOnMap(controller, latLngs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            markers: _markers,
            onMapCreated: (a) {
              _onMapCreated(a, []);
            },
            onCameraIdle: () {
              onCameraIdle([]);
            },
          ),
          Container(
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.h),
                    bottomLeft: Radius.circular(25.h))),
            child: SafeArea(
              bottom: false,
              child: ListView(

                children: [
                  PlacesAutocompleteWidget(
                    language: 'EN',
                    onError: (PlacesAutocompleteResponse response) {
                      print(response.errorMessage);
                    },
                    apiKey: GlobalConfiguration().getString('geo_code_key'),
                    components: <Component>[Component(Component.country, 'NG')],
                  ),

                  SizedBox(height: 10.h),
             /*     regularText(
                    'Recent search',
                    color: AppColors.lightBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            routeTo(context, LocationDetailsView());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 22.h,
                                  color: AppColors.lightBlack,
                                ),
                                SizedBox(width: 10.h),
                                Expanded(
                                  child: regularText('Surabaya',
                                      color: AppColors.lightBlack,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 10.h),
                                regularText('34° / 23°',
                                    color: AppColors.lightBlack,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                        );
                      }),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
