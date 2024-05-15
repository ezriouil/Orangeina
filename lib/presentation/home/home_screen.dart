import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends CustomState {
  const HomeScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch(state){
            case HomeCurrentState(): return Center(child: Column(
              children: [
                Text("home screen", style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                CustomElevatedButton(child: Text("Sign out"), onClick: ()async{
                  await FirebaseAuth.instance.signOut();
                  context.pushReplacementNamed(CustomRouter.LOGIN);
                })
              ],
            ));
            case HomeLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case HomeErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}
