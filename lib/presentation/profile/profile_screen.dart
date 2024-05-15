import 'package:berkania/presentation/profile/profile_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends CustomState {
  const ProfileScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          switch(state){
            case ProfileCurrentState(): return Center(child: Column(
              children: [
                Text("Profile screen", style: Theme.of(context).textTheme.bodyLarge)
              ],
            ));
            case ProfileLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case ProfileErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}
