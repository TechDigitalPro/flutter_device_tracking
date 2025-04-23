import 'package:device_tracking/views/items/item_device_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/widget_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/main/main_view_model.dart';

// ignore: must_be_immutable
class MainView extends StatefulWidget {
  MainView({this.selectedIndex, super.key});

  int? selectedIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (viewModel) => viewModel.initialize(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(BuildContext context, MainViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorPrimaryDark);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, details) async {
        if (result) return;
        showDialog(
          context: context,
          builder: (BuildContext dlgContext) => const ExitDialog(),
        );
      },
      child: SizedBox(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorPrimaryDark,
          appBar: AppBar(
            backgroundColor: ColorUtils.appColorPrimaryDark,
            title: textView(
              StringUtils.txtHome,
              textColor: ColorUtils.appColorWhite,
              fontSize: SizeUtils.textSizeXLarge,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  model.onClickLogout(context);
                },
                icon: Icon(Icons.logout, color: ColorUtils.appColorWhite),
              ),
            ],
          ),
          body: SafeArea(
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageUtils.imgIcLogo,
                      width: width,
                      height: height * 0.2,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: BoxDecoration(
                      color: ColorUtils.appColorBlack_50,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: SizedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: width * 0.2,
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: textView(
                                    StringUtils.txtUser,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    textColor: ColorUtils.appColorWhite,
                                    maxLine: 1,
                                  ),
                                ),
                                Container(
                                  width: width * 0.3,
                                  alignment: Alignment.centerLeft,
                                  child: textView(
                                    StringUtils.txtDescription,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    textColor: ColorUtils.appColorWhite,
                                    maxLine: 1,
                                  ),
                                ),
                                Container(
                                  width: width * 0.2,
                                  alignment: Alignment.centerLeft,
                                  child: textView(
                                    StringUtils.txtStatus,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    textColor: ColorUtils.appColorWhite,
                                    maxLine: 1,
                                  ),
                                ),
                                Container(
                                  width: width * 0.1,
                                  alignment: Alignment.centerLeft,
                                  child: textView(
                                    StringUtils.txtDelete,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    textColor: ColorUtils.appColorWhite,
                                    maxLine: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: ColorUtils.appColorWhite_80,
                          margin: EdgeInsets.all(10),
                        ),
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: getList(context, model),
                        )
                      ],
                    )
                  ))
                ],
              ),
            ),
          ),
          bottomNavigationBar: Material(
            elevation: 0,
            color: ColorUtils.appColorTransparent,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorUtils.appColorBlack_50,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 25,
                          icon: Icon(
                            Icons.person,
                            color: ColorUtils.appColorWhite,
                            size: 40,
                          ),
                          onPressed: () {
                            model.onClickProfile(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 25,
                          icon: Icon(
                            Icons.home,
                            color: ColorUtils.appColorWhite,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 25,
                          icon: Icon(
                            Icons.bluetooth,
                            color: ColorUtils.appColorWhite,
                            size: 40,
                          ),
                          onPressed: () {
                            model.onClickBluetooth(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getList(BuildContext context, MainViewModel model) {
    return model.mList.map((item) {
      return ItemDeviceView(
        model: item,
        onDelete: (){
          showDialog(
            context: context,
            builder: (BuildContext dlgContext) {
              return CustomDialog(
                title: StringUtils.txtConfirm,
                description: StringUtils.txtAreYouSureYouWantToRemove,
                okButtonStr: StringUtils.txtRemove,
                cancelButtonStr: StringUtils.txtCancel,
                okClicked: () {
                  model.onClickDelete(context, item);
                });
            },
          );
        },
        onAddRemove: () {
          
        }
      );
    }).toList();
  }
}
