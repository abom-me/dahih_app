import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/profile/component/change_profile.dart';
import 'package:khlfan_shtain/settings/sizes.dart';

import '../../utils/enum/gender_enum.dart';
import '../../utils/global_keys.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(Lang.get(context, key: LangKey.profile)),

      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        width: Sizes.width(context),
        height: Sizes.height(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                 bottomSheetBlur(context, widget: SelectAvatar(), height: 700);
                },
                child: Container(
                width: 120,
                  height: 120,
                    // padding: const EdgeInsets.only(top: 120),
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.bottomCenter,
                    // height: 210,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        border: const Border(
                            bottom: BorderSide.none
                        )
                    ),

                    child: userData.profileImage=="" || userData.profileImage==null ? userData.gender==GenderEnum.male.gender?Image.asset(

                      "assets/avatars/i5.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ):Image.asset(

                      "assets/avatars/i43.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ): Image.asset(
                      "assets/avatars/${userData.profileImage}",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    )),
              ),
              const SizedBox(height: 20,),
              Text(userData.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),),
              const SizedBox(height: 50,),
              ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Container(
padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  width: Sizes.width(context),
                  height: 300,
                 decoration:  BoxDecoration(
                   borderRadius: BorderRadius.circular(25),
                   color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                 ),
                  child:  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Text("${Lang.get(context, key: LangKey.statistics)} 🚀",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),),

                      BackdropFilter(

                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                                      alignment: Alignment.center,
                          // width: Sizes.width(context),
                          height: 300,
                          width: Sizes.width(context),
                          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),


                          ),
                                      child: Text("${Lang.get(context, key: LangKey.soon)} 🤩📊",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),),

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
    );
  }
}
